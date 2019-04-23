library(ggplot2)
library(reshape)

pad <- function(x, n) {
  len.diff <- n - length(x)
  c(x, rep(NA, len.diff))
}

minutes <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 19, 20, 29, 30, 39, 40, 49, 50)
native_1 <- c(0.372,0.303,0.245,0.313,0.309,0.335,0.316,0.318,0.277,0.333,0.299,0.277,0.321,0.234,0.199,0.181,0.097,0.269,0.222)
native_2 <- c(0.392,0.237,0.298,0.298,0.217,0.181,0.231,0.22,0.216,0.232,0.217,0.234,0.196,0.175,0.133)
denat_1 <- c(0.413,0.348,0.376,0.371,0.381,0.385,0.359,0.363,0.389,0.297,0.354,0.248,0.333,0.203,0.28,0.298,0.139,0.278,0.34)
denat_2 <- c(0.346,0.354,0.333,0.349,0.297,0.354,0.305,0.294,0.338,0.249,0.308)
reduced_1 <- c(0.393,0.305,0.283,0.24,0.201,0.215,0.156,0.301,0.32,0.303,0.258,0.213,0.255)
reduced_2 <- c(0.393,0.305,0.283,0.24,0.201,0.215,0.156,0.301,0.32,0.303,0.258,0.213,0.255,0.632,0.662)

min_l = length(minutes)

native_1 <- pad(native_1, length(minutes))
native_2 <- pad(native_2, length(minutes))
denat_1 <- pad(denat_1, length(minutes))
denat_2 <- pad(denat_2, length(minutes))
reduced_1 <- pad(reduced_1, length(minutes))
reduced_2 <- pad(reduced_2, length(minutes))

df <- data.frame(minutes, native_1, native_2, denat_1, denat_2, reduced_1)
df.melted <- melt(df, id = "minutes")

df_native <- data.frame(minutes, native_1, native_2)
df_native.melted <- melt(df_native, id = "minutes")

df_denat <- data.frame(minutes, denat_1, denat_2)
df_denat.melted <- melt(df_denat, id = "minutes")

df_reduced <- data.frame(minutes, reduced_2, reduced_1)
df_reduced.melted <- melt(df_reduced, id = "minutes")

ggplot(data = df_native.melted, aes(x = minutes, y = value, color = variable)) +
  labs(y = "Absorption", x = "Zeit [min]", title = "Absorption bei 578 nm") +
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE)

ggplot(data = df_denat.melted, aes(x = minutes, y = value, color = variable)) +
  labs(y = "Absorption", x = "Zeit [min]", title = "Absorption bei 578 nm") +
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE)

ggplot(data = df_reduced.melted, aes(x = minutes, y = value, color = variable)) +
  labs(y = "Absorption", x = "Zeit [min]", title = "Absorption bei 578 nm") +
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE)

ggplot(data = df.melted, aes(x = minutes, y = value, color = variable)) +
  labs(y = "Absorption", x = "Zeit [min]", title = "Absorption bei 578 nm") +
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE)