library(rvest)
library(tidyverse)
library(dplyr)
library(readxl)

HallofFame <- read_excel("C:/Users/jerem/Desktop/Spring Semester 2020/STAT480/HallofFame.xlsx")

HallofFame2 <- HallofFame %>%
  mutate(Pos = str_replace(Pos, "DG", "OL")) %>%
  mutate(Pos = str_replace(Pos, "TB", "RB")) %>%
  mutate(Pos = str_replace(Pos, "T", "OL")) %>%
  mutate(Pos = str_replace(Pos, "G", "OL")) %>%
  mutate(Pos = str_replace(Pos, "C", "OL")) %>%
  mutate(Pos = str_replace(Pos, "E", "Flex")) %>%
  mutate(Pos = str_replace(Pos, "OLFlex", "TE")) %>%
  mutate(Pos = str_replace(Pos, "DFlex", "DE")) %>%
  mutate(Pos = str_replace(Pos, "DOL", "DT")) %>%
  mutate(Pos = str_replace(Pos, "HB", "RB")) %>%
  mutate(Pos = str_replace(Pos, "FL", "Flex")) %>%
  mutate(Pos = str_replace(Pos, "SFlex", "WR")) %>%
  mutate(Pos = str_replace(Pos, "WB", "FB"))

write.csv(HallofFame2, "C:/Users/jerem/Desktop/Spring Semester 2020/STAT480/HoFPlayer_Position.csv")