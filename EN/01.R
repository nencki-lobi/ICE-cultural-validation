# library('RPostgreSQL')
library('dplyr')
library('tidyr')
library("openxlsx")

## Connect to database

# pg = dbDriver("PostgreSQL")
# 
# con = dbConnect(pg, user="grieg", password="",
#                 host="localhost", port=5432, dbname="grieg")

## Load data

# query = "SELECT
# s.sid, s.code, e.respondent_id AS rid,
# q.name, a.ord, a.val
# FROM subject s
# JOIN external_infact e ON e.sid = s.sid
# JOIN quest q ON q.sid = s.sid
# JOIN answer a ON a.qid = q.qid
# WHERE s.stid = 6 AND s.qidv_idx > 12
# AND q.name IN ('demo-0-en', 'ICE-60-en')
# ORDER BY s.sid, q.name, a.ord"
# 
# df = dbGetQuery(con, query)
# save(df, file = "./01/input/dataset.RData")

load(file = "./01/input/dataset.RData")

## Get data needed for quality control

demo = c(0,1,3,4:6) # CC concern, sex, birth, country, languages
checks = c(19,34,44) # CHECK questions

data1 = filter(df, (name == 'demo-0-en' & ord %in% demo) | 
                   (name == 'ICE-60-en' & ord %in% checks))

data1 = select(data1, sid, code, rid, name, ord, val) %>%
  pivot_wider(id_cols = c("sid", "code", "rid"),
              names_from = c("name", "ord"),
              names_sep = ".",
              values_from = "val")

colnames(data1) = c("sid", "code", "rid", "CHECK1", "CHECK2", "CHECK3",
                    "CC", "sex", "birth", "country", "language1", "language2")

data1 = data1 %>% mutate(across(4:9, as.integer))

## Get company data needed for quality control

data2 = read.xlsx("./01/input/Syno_InFact_Climate change Norway and Ireland March 2022_Ireland_Raw data_25052022.xlsx")
data2 = data2[,c(3,14,6,5)]

colnames(data2) = c("rid", "CC", "sex", "birth")

data2$sex = recode(data2$sex, "Female" = 0, "Male" = 1, "Other" = 2)
data2$CC = recode(data2$CC, "1 - Not at all concerned" = 0, "2" = 0,
                                   "3" = 1, "4"= 1, 
                                   "5" = 2, "6" = 2, 
                                   "7" = 3, "8" = 3, 
                                   "9" = 4, "10 - Extremely concerned" = 4)

## Remove test data

data = data1 %>%
  inner_join(data2, by = "rid", suffix=c(".1",".2"))

sprintf('Final sample size: N = %d', nrow(data)) # initial sample size

## Clean data based on quality criteria

# country & languages

data = data %>% filter(country == "Ireland")
data = data %>% filter(language1 == "English" | language2 == "English")

# consistent reporting on sex
data = data %>% mutate(sex.matches = (sex.1 == sex.2))

# consistent reporting on age, with difference of 1 year acceptable
data = data %>% mutate(birth.matches = (birth.1 == birth.2))

# consistent reporting on CC concern, with difference of up to 2 points acceptable
data = data %>% mutate(CC.matches = (abs(CC.1 - CC.2) < 3))

# correct responses to control questions
data = data %>% mutate(acceptable.checks = ((CHECK1 == 0) + (CHECK2 == 2) + (CHECK3 == 4) > 2))

data = filter(data, sex.matches == TRUE 
                & birth.matches  == TRUE
                #& CC.matches == TRUE 
                & acceptable.checks == TRUE)

sprintf('Final sample size: N = %d', nrow(data)) # final sample size

## Save output

subjects = data[,c("sid", "code", "rid")]
save(subjects, file = "./01/output/subjects.RData")
