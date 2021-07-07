# Autobahn plotting
library(data.table)

autoBahn <- read.csv("paper/assets/autobahn", header = FALSE)[[1]]
cities <- read.csv("paper/assets/topCities", sep = ";")[, "Name"]

# create edgelist
roadList <- list()
i <- 0
for (nr in autoBahn) {
  i <- i + 1
  #split into sting
  tempRoad <- unlist(x = strsplit(nr, split = ";"))
  id <- tempRoad[[1]]
  road <- list()
  for (x in seq_along(tempRoad)[-c(1, length(tempRoad))]) {
    road[[x - 1]] <- data.table(tempRoad[x], tempRoad[x + 1], id)
  }
  roadList[[i]] <- do.call(rbind, road)
}

edges <- do.call(rbind, roadList)
nodes <- data.frame(name = unique(c(edges$V1, edges$V2)))


library(ggplot2)
library(igraph)
library(ggraph)

autoB <- graph_from_data_frame(edges, nodes, directed = FALSE)

transitivity(autoB, type = "global")

ggraph(autoB, layout = "stress") +
  geom_edge_parallel(aes(color = ifelse(id == 9, id, NA)),
                     col = "light grey") +
  geom_node_point(col = "dark grey") +
  geom_node_text(aes(label = ifelse(name %in% cities, name, NA)),
                     check_overlap = TRUE, nudge_y = 0.4, size = 2) +
  theme(panel.background = element_rect(fill ="white"),
        legend.position = "none")

ggsave("paper/plots/autoBahn.png", device = "png", width = 5, height = 2.5)

library(node2vec)
library(Rtsne)
library(factoextra)

n2vDat <- as.data.frame(edges[, -3])

attempt <- node2vecR(n2vDat,p=0.5,q=1,num_walks=10,walk_length=12)

tsneAttempt <- Rtsne(attempt, dims = 2, perplexity=30, verbose=TRUE, max_iter = 500)
dat1 <- cbind(name = rownames(attempt), as.data.table(tsneAttempt$Y))
#a9 <- as.data.table(dat1)[data.table(name = c("Berlin","Dessau","Leipzig","Hof","Bayreuth","Nürnberg","Ingolstadt","München"), ord = 1:8), , on = ("name" = "name")]
ggplot(dat1, aes(x = V1, y = V2)) +
  geom_point(color = "dark grey") +
  #labs(title = "AB n2v Vis. with tSNE") +
  geom_text(aes(label = ifelse(name %in% cities, name, NA)), 
            nudge_y = -.2, nudge_x = .2, size = 1.5) +
  #geom_path(data = a9, color = "red", alpha = 0.6, size = .2) +
  theme_minimal()+
  theme(axis.title.x = element_blank(),
        axis.text.x = element_text(size = 5),
        axis.text.y = element_text(size = 5),
        axis.title.y = element_blank())

ggsave("paper/plots/autoBahnEmbedding.png", device = "png")

fviz_pca_ind(prcomp(attempt), label = FALSE)


attempt2 <- node2vecR(as.data.frame(edges[, -3]), p = 0.25, q = 0.25)


tsneAttempt2 <- Rtsne(attempt2, dims = 2, perplexity=30, verbose=TRUE, max_iter = 500)
dat2 <- cbind(name = rownames(attempt2), as.data.table(tsneAttempt2$Y))
ggplot(dat2, aes(x = V1, y = V2)) +
  geom_point(aes(color = ifelse(name %in% c("Berlin","Dessau","Leipzig","Hof","Bayreuth","Nürnberg","Ingolstadt","München"), name, NA)))


attempt3 <- node2vecR(as.data.frame(edges[, -3]), p = 4, q = 1)

tsneAttempt3 <- Rtsne(attempt3, dims = 2, perplexity=30, verbose=TRUE, max_iter = 500)
plot(tsneAttempt3$Y, main="tsne")
