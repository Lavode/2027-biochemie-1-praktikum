library(ggplot2)
library(ggrepel)
library(reshape)
library(dplyr)
library(scales)

# Our values
n14_with = c(139884.392121772, 135924.507502138)
n14_without = c(146774.717741521, 428253.327996268)
df14 = data.frame(
  sample = c("N+", "N-"),
  sq = c(mean(n14_with), mean(n14_without)),
  stdev = c(sd(n14_with), sd(n14_without))
)

ggplot(df14, aes(sample, sq)) +
  labs(y = "Starting quantity [geq / μl]", x = "Sample", title = "DNA starting quantity of samples with / without neuraminidase (Group 14)") +
  geom_col() +
  geom_errorbar(aes(ymin = sq - stdev, ymax = sq + stdev))


# Better values from another group
nid_with = c(60200, 66300)
nid_without = c(488000, 630000)
dfid = data.frame(
  sample = c("N+", "N-"),
  sq = c(mean(nid_with), mean(nid_without)),
  stdev = c(sd(nid_with), sd(nid_without))
)
ggplot(dfid, aes(sample, sq)) +
  labs(y = "Starting quantity [geq / μl]", x = "Sample", title = "DNA starting quantity of samples with / without neuraminidase (Foreign group)") +
  geom_col() +
  geom_errorbar(aes(ymin = sq - stdev, ymax = sq + stdev))
