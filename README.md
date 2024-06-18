# Cross-cultural validation of the Inventory of Climate Emotions (ICE)

This repository contains supplementary materials (data and code) associated with the manuscript describing the cross-cultural validation of the of the Inventory of Climate Emotions (ICE). The remaining supplementary materials can be found on the accompanying [OSF website](https://osf.io/r8g6h/).

Please cite the corresponding publication when using these materials:

> Marczak, M., Wierzba, M., Kossowski, B., Marchewka A., Morote, R., & Klöckner, C.A. (2024) *Emotional responses to climate change in Norway and Ireland: a validation of the Inventory of Climate Emotions (ICE) in two European countries and an inspection of its nomological span*. Frontiers in Psychology, 15. [https://doi.org/10.3389/fpsyg.2024.1211272](https://doi.org/10.3389/fpsyg.2024.1211272)

## Contents

This repository contains raw and cleaned data collected in the three countries:
* [Norway](https://github.com/nencki-lobi/ICE-cultural-validation/raw/main/NO)
* [Ireland](https://github.com/nencki-lobi/ICE-cultural-validation/raw/main/EN)
* [Poland](https://github.com/nencki-lobi/ICE-cultural-validation/raw/main/PL)

Morover, we share data analysis code, as well final HTML reports.

## How to use

To reproduce the analyses described in the manuscript, run:

* ICE Norway ([HTML report](https://github.com/nencki-lobi/ICE-cultural-validation/blob/main/ICE_Norway.html)):

```
rmarkdown::render("ICE_Norway.Rmd", output_file = "ICE_Norway.html")
```

* ICE Ireland ([HTML report](https://github.com/nencki-lobi/ICE-cultural-validation/blob/main/ICE_Ireland.html)):

```
rmarkdown::render("ICE_Ireland.Rmd", output_file = "ICE_Ireland.html")
```

* ICE measurement equivalence ([HTML report](https://github.com/nencki-lobi/ICE-cultural-validation/blob/main/ICE_measurement_equivalence.html)):

```
rmarkdown::render("ICE_measurement_equivalence.Rmd", output_file = "ICE_measurement_equivalence.html")
```

* ICE measurement equivalence (additional analyses) ([HTML report](https://github.com/nencki-lobi/ICE-cultural-validation/blob/main/ICE_measurement_equivalence_extras.html)):

```
rmarkdown::render("ICE_measurement_equivalence_extras.Rmd", output_file = "ICE_measurement_equivalence_extras.html")
```

## Requirements

The following R packages are required: `astatur`, `ggcorrplot`, `knitr`, `lavaan`, `lmtest`, `mvnormalTest`, `openxlsx`,`paletteer`, `psych`, `tidyverse`.

Optional, but useful for working with PostgreSQL databases: `RPostgreSQL`.

## Contact information:

If you would like to use Inventory of Climate Emotions (ICE) in your research please contact Michalina Marczak (michalina.marczak@ntnu.no).

Any problems or concerns regarding this repository should be reported to Małgorzata Wierzba (m.wierzba@nencki.edu.pl).
