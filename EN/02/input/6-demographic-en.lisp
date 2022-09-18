;;;; -*-coding: utf-8;-*-

(in-package :grieg)

(define-flexible-questionnaire "demo-0-en"
  :title "Demographic questions"
  :localization :en
  :genderized nil
  :next "NEXT"
  :back "BACK"
  :items
  `((:sc "How concerned are you about climate change?"
     :opt ("Not at all concerned"
           "Not very concerned"
           "Somewhat concerned"
           "Very concerned"
           "Extremely concerned"))
    (:sc "What is your gender?"
     :opt ("Female"
           "Male"
           ("Other" :subq ((:te "Please specify:")))))
    (:te "Please state your year of birth."
     :verifier ,(in-interval-checker 1900 2022 :message "Value must be in the range from ~a to ~a."))
    (:te "Please indicate the country you currently live in."
     :helptext "Give your permanent, not temporary place of
     residence (e.g. for a holiday or business trip)."
     :completions ,*countries-en*)
    (:te "Which language do you usually use at home? Indicate the
    first language you use most often:"
     :completions ,*languages-en*)
    (:te "Do you speak any other languages at home? If yes, please
    indicate the second language you use most often:"
     :helptext "Optional question."
     :optional t
     :completions ,*languages-en*)
    (:sc "Which of the following best describes the area where you live?"
     :opt ("A big city"
           "The suburbs or outskirts of a big city"
           "A town or a small city"
           "A country village"
           "A farm or home in the countryside"))
    (:sc "What is the highest level of education you have successfully completed?"
     :opt ("Primary education"
           "Secondary education"
           "Vocational training"
           "University/College degree"
           ("Other" :subq ((:te "Please specify:")))))
    (:sc "Do you have any political views?"
     :opt ("No"
           ("Yes" :subq ((:sc "In politics, the terms “left” and
           “right” are sometimes used. Can you characterise your
           political views using these concepts?"
                          :opt ("No"
                                ("Yes" :id "yes"))
                          :id "p2"))
                  :id "yes"))
     :id "p1")
    (:scale "Please indicate your political views."
     :helptext "On the scale below, 0 means left and 10 – right. The
     other numbers are to be used to express intermediate views."
     :visible-if (:and (:selected "p1" "yes") (:selected "p2" "yes"))
     :ends (0 10)
     :descriptions ("Left" "Right"))
    (:sc "Which of the descriptions below comes closest to how you
    feel about your household’s income nowadays?"
     :opt ("Living comfortably on present income"
           "Coping on present income"
           "Finding it difficult on present income"
           "Finding it very difficult on present income"))))
