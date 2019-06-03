library(ggplot2)

df = read.csv("../data/fatty_acids.csv")

ggplot(df, aes(x = fatty_acid, y = area_percent, fill = sample)) +
  labs(title = "Konzentration verschiedener Membranlipide bei unterschiedlicher Temperatur", x = "Fettsäuren", y = "Konzentration [%]") +
  geom_bar(stat = "identity", position = "dodge")


df_all = read.csv("../data/fatty_acids_all.csv")
df_all_aggr = aggregate(df_all$area_percent, by=list(sample=df_all$sample, size=df_all$size), FUN=sum)

df_20 = df_all_aggr[df_all_aggr$sample == "20°C", ]
df_37 = df_all_aggr[df_all_aggr$sample == "37°C", ]
weighted.mean(df_20$size, df_20$x)
weighted.mean(df_37$size, df_37$x)

ggplot(df_all_aggr, aes(x = size, y = x, colour = sample)) +
  labs(title = "Konzentration verschiedener Membranlipide nach Länge bei unterschiedlicher Temperatur", x = "Länge der Kette [C Atome]", y = "Konzentration [%]") +
  geom_point() + 
  geom_line()


