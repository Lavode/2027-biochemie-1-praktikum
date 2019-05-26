library(ggplot2)

df = read.csv("optical_density.csv")
ggplot(df, aes(x=minutes, y=od)) +
  labs(y = "OD", x = "Inkubationszeit [min]", title = "Optische Dichte der Bakterienkultur") +
  scale_x_continuous(breaks = seq(min(df$minutes), max(df$minutes), 20)) +
  geom_point()


transformation_rates = c(308264, 281809, 293886, 195541)
mean(transformation_rates)
sd(transformation_rates)

absorption_rates = c(0.00393, 0.003592, 0.003746, 0.002493)
mean(absorption_rates)
sd(absorption_rates)
