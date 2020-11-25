# Observe the relationship between the parameters
wdbc <- read.csv("../data/wdbc.csv")
d_s <- data.frame(scale(wdbc[c("radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension")]))
library(psych)
pairs.panels(d_s)
