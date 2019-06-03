library(ggplot2)
library(tidyverse)

# Enzyme concentration

df_optimal_conc = read.csv('optimal_concentration.csv')
df_optimal_conc$velocity = 1 / df_optimal_conc$time
df_optimal_conc[10, 4] = 0
df_optimal_conc[11, 4] = 0
df_optimal_conc[12, 4] = 0
optimal_conc = df_optimal_conc %>% 
  group_by(units) %>% 
  summarize(
    avg = mean(velocity),
    sd = sd(velocity)
  )
optimal_conc.lm2 <- lm(avg ~ 0 + units, data = optimal_conc) # Adding the 0 term tells the lm() to fit the line through the origin

ggplot(optimal_conc, aes(x = units, y = avg)) +
  labs(title = "Surfacing velocity under different enzyme concentrations", x = "Concentration [Units/ml]", y = "Velocity [1/s]") +
  geom_point() +
  geom_errorbar(aes(ymin = avg - sd, ymax = avg + sd), width=.8, position=position_dodge(.9)) +
  geom_abline(intercept = 0, slope=optimal_conc.lm2$coefficients[1], color='#0000FF', size=1.1) +
  annotate("text", x = 10, y = 0.08, label = "f(x) = 0.000921 * x")
  

# Substrate concentration

df_substrate_conc = read.csv('substrate_concentration.csv')
df_substrate_conc$velocity = 1 / df_substrate_conc$time
substrate_conc = df_substrate_conc %>% 
  group_by(concentration) %>% 
  summarize(
    avg_v = mean(velocity),
    sd_v = sd(velocity)
  )

ggplot(substrate_conc, aes(x = concentration, y = avg_v)) +
  labs(title = "Surfacing velocity under different substrate concentrations", x = "H2O2 Concentration [%]", y = "Velocity [1/s]") +
  scale_x_continuous(labels = scales::percent) +
  geom_point() +
  geom_errorbar(aes(ymin = avg_v - sd_v, ymax = avg_v + sd_v), width=.001, position=position_dodge(.9))



# pH

df_ph = read.csv('ph_influence.csv')
df_ph$velocity = 1 / df_ph$time
ph = df_ph %>% 
  group_by(ph) %>% 
  summarize(
    avg_v = mean(velocity),
    sd_v = sd(velocity)
  )

ggplot(ph, aes(x = ph, y = avg_v)) +
  labs(title = "Surfacing velocity under different pH", x = "pH", y = "Velocity [1/s]") +
  geom_point() +
  geom_errorbar(aes(ymin = avg_v - sd_v, ymax = avg_v + sd_v), width=.1, position=position_dodge(.9))


# Inhibition

df_inh = read.csv('inhibition.csv')
df_inh$velocity = 1 / df_inh$time

inh = df_inh %>%
  group_by(conc_substr, conc_inh) %>% 
  summarize(
    avg_v = mean(velocity),
    sd_v = sd(velocity)
  )


ggplot(inh, aes(x = conc_substr, y = avg_v)) +
  labs(title = "Surfacing velocity under different substrate concentrations, inhibited with hydroxylaminase", x = "H2O2 Concentration [%]", y = "Velocity [1/s]") +
  scale_x_continuous(labels = scales::percent) +
  geom_point() +
  geom_errorbar(aes(ymin = avg_v - sd_v, ymax = avg_v + sd_v), width=.001, position=position_dodge(.9))



