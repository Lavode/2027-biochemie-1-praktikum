library(ggplot2)

df = read.csv("optical_density.csv")
ggplot(df, aes(x=minutes, y=od)) +
  labs(y = "OD", x = "Inkubationszeit [min]", title = "Optische Dichte der Bakterienkultur") +
  scale_x_continuous(breaks = seq(min(df$minutes), max(df$minutes), 20)) +
  geom_point()
