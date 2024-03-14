#!/bin/R

library("vegan")
spatial_data <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(2, 3, 4, 5, 6),
  z = c(3, 4, 5, 6, 7),
  v1 = c(2.5, 3.1, 4.2, 1.8, 5.6),  # Variable 1
  v2 = c(1.2, 2.8, 3.9, 2.5, 4.7)   # Variable 2
)

# Compute 3D spatial distances
spatial_dist <- dist(cbind(spatial_data$x, spatial_data$y, spatial_data$z))

# Compute Mantel Test for v1 and v2
mantel_test_result <- mantel(spatial_dist, cor(spatial_data$v1, spatial_data$v2))


corrrlation_v1v2 <- mantel_test_result$estimate