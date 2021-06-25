library(GGally)
library(network)
library(sna)
library(ggplot2)
library(igraph) 

rmdPath <- "paper/"


### Example Graph plot

# data <- matrix(sample(0:1, 225, replace=TRUE, prob=c(0.85,0.15)), nrow=15)
set.seed(2333)
exGraph <- rbindlist(list(list(from = NULL, to = NULL, prob = NULL),
                  list("t", "v", "1/p"),
                  list("t", "x3", 0),
                  list("v", "x3", 1),
                  list("v", "x1", "1/q"),
                  list("v", "x2", "1/q"),
                  list("x2", "x3", 0),
                  list("x2", "c", 0),
                  list("x1", "c", 0),
                  list()))

net = network(exGraph, directed = FALSE)

ggnet2(net, label = TRUE, edge.label = exGraph$prob)

ggsave(paste0(rmdPath, "plots/exGraph.pdf"), device = "pdf")

###