library(table1)
library(r2rtf)
library(haven)
library(dplyr)
library(tidyr)
library(stringr)
library(tools)

ana <- adsl %>%
  mutate(
    SEX = factor(SEX, c("F", "M"), c("Female", "Male")),
    RACE = toTitleCase(tolower(RACE))
  )

tbl <- table1(~ SEX + AGE + RACE | TRT01P, data = ana)

tbl_base <- tbl %>%
  as.data.frame() %>%
  as_tibble() %>%
  mutate(across(
    everything(),
    ~ str_replace_all(.x, intToUtf8(160), " ")
  ))


names(tbl_base) <- str_replace_all(names(tbl_base), intToUtf8(160), " ")
tbl_base
colheader1 <- paste(names(tbl_base), collapse = "|")
colheader2 <- paste(tbl_base[1, ], collapse = "|")
rel_width <- c(2.5, rep(1, 4))

tbl_base[-1, ] %>%
  rtf_title(
    "Baseline Characteristics of Participants",
    "(All Participants Randomized)"
  ) %>%
  rtf_colheader(colheader1,
                col_rel_width = rel_width
  ) %>%
  rtf_colheader(colheader2,
                border_top = "",
                col_rel_width = rel_width
  ) %>%
  rtf_body(
    col_rel_width = rel_width,
    text_justification = c("l", rep("c", 4)),
    text_indent_first = -240,
    text_indent_left = 180
  ) %>%
  rtf_encode() %>%
  write_rtf("tlf/tlf_base.rtf")

