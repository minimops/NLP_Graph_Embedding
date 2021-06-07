library(GGally)
library(network)
library(sna)
library(ggplot2)


rmdPath <- "paper/"


### Example Graph plot

# data <- matrix(sample(0:1, 225, replace=TRUE, prob=c(0.85,0.15)), nrow=15)
data <- rgraph(15, mode = "graph", tprob=0.2)
net = network(data, directed = FALSE)
ggnet2(data, label = letters[1:15])

ggsave(paste0(rmdPath, "plots/exGraph.pdf"), device = "pdf")

###