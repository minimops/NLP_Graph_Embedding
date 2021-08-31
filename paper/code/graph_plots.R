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

ggnet2(net, label = TRUE, edge.label = exGraph$prob, size = 8, mode = "kamadakawai")

ggsave(paste0(rmdPath, "plots/exGraph.pdf"), device = "pdf", width = 2.9, height = 2.9)

###


n2vgraph <- rbindlist(list(list(from = NULL, to = NULL),
                           list("a", "b"),
                           list("a", "c"),
                           list("b", "c"),
                           list("c", "d"),
                           list("c", "e"),
                           list("e", "f"),
                           list("f", "g"),
                           list("f", "h"),
                           list("g", "i"),
                           list("h", "i")))

net = network(n2vgraph, directed = FALSE)

ggnet2(net, label = TRUE, size = 8,
       mode = "kamadakawai")

ggsave(paste0(rmdPath, "plots/n2vgraph.pdf"), device = "pdf", 
       width = 3, height = 3)

###

rw1 <- rbindlist(list(list(from = NULL, to = NULL),
                           list("1", "2"),
                           list("2", "3"),
                           list("3", "4"),
                           list("4", "5"))) 

net = network(rw1, directed = TRUE)
ggraph(net)
ggnet2(net, label = TRUE, size = 8, node.label = c("f", "e", "f", "h", "i"),
       mode = "rmds")

ggsave(paste0(rmdPath, "plots/n2vgraph.pdf"), device = "pdf", 
       width = 3, height = 3)
                      