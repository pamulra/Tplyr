
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
count_list <- adsl %>%
              filter( SAFFL == "Y") %>%
              group_by(TRT01A) %>%
              summarise(N=n()) %>%
              pivot_wider(names_from = TRT01A, values_from = N) %>%
              mutate(newcol = "Number of Subjects in the Population")
              # %>% select(newcol)

# How to create a column count per

