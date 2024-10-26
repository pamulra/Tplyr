
library(dplyr)
library(Tplyr)
library(tidyr)

tplyr_table(tplyr_adsl, TRT01P, where = SAFFL == "Y") %>%
  # add_layer(
  #   group_desc(AGE, by = "Age (years)")
  # ) %>%
  add_layer(
    group_count(vars(TRT01A, AGEGR1))
  ) %>%
  build()

# Counting subjects who's completed the study and by treatment
count_list <- list()
count_list <- adsl %>% group_by(TRT01A) %>% summarise(N=n())

small_n  <- count_list %>% pivot_wider(names_from = TRT01A, values_from = N)
