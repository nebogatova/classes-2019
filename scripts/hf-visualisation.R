#' import libraries
library(tidyverse)
library(here)
hf_summary <- read_csv("output/summary.csv")
hf_summary


#' age vs post acute LOS scatterplot
ggplot(data = hf_summary) +
  geom_point(aes(x = age, y = acute_LOS, color = county))

#'Modify previous plot so that county will be on facets
ggplot(data = hf_summary) +
  geom_point(aes(x = age, y = acute_LOS, color = county)) +
  facet_wrap( ~ county) +
  scale_y_log10()

#' Create line graph wih loss smoth
ggplot(data = hf_summary) +
  geom_smooth(aes(x = age, y = acute_LOS)) +
  facet_wrap( ~ county) +
  scale_y_log10()

#' Linear regression line:
ggplot(data = hf_summary) +
  geom_smooth(aes(x = age, y = acute_LOS), method = "lm") +
  facet_wrap( ~ county) +
  scale_y_log10()

#'
ggplot(data = hf_summary, aes(x = age, y = acute_LOS)) +
  geom_point(size = 0.3, alpha =0.3, position =  position_jitter(0.5)) +
  geom_smooth(aes(color = fracture_type), method = "lm") +
  facet_wrap( ~ county) +
  scale_y_log10()


#' Plot mean length of stay +/- 1sd per county
ggplot(data = hf_summary) + 
  stat_summary(
    mapping = aes(x = county, y = acute_LOS),
                             fun.data = mean_sdl,
                              fun.args = list(mult = 1))+
  labs (y = "acute length of stay\nafter hip fracture, days")+
  theme (axis.text.x = element_text(angle = 45,vjust = 1,hjust = 1),
         axis.title.x = element_blank())

#' Number of fracture types in hf_summary dataset
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, y = ..prop.., group = 1))

#
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, y = ..prop.., fill = sex, group = sex))

#
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = "dodge")

#
ggplot(data = hf_summary) +
  geom_bar(aes(x = fracture_type, fill = sex), position = position_dodge(width = 0.5))
