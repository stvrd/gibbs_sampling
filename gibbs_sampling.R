# Understanding Gibbs Sampling
# from https://www.youtube.com/watch?v=ER3DDBFzH2g
library(tidyverse)

# A and B two horses
# 0 = the horse loses its race
# 1 = the horse wins its race

A <- c(0,0,0,0,1,1,1,1,1,1)
B <- c(0,1,1,1,0,0,0,0,1,1)
outcomes <- tibble(B,A)
outcomes <- table(outcomes)

# Joint pdf - this one we want to find
joint_pdf <- prop.table(outcomes)
plot(joint_pdf)

# conditional pdf P(A|B)
cond_b <- prop.table(outcomes,margin = 1)
cond_b <- data.frame(cond_b)

# conditional pdf P(B|A)
cond_a <- prop.table(outcomes,margin = 2)
cond_a <- data.frame(cond_a)

# Gibbs sampling algorithm (asymptotically converges)
T <- 300
support <- c(0,1)

# initialize sample tibble:
gibbs <- tibble(B=rep(NA,T), A = rep(NA,T))
gibbs[1,] <- sample(support,2,replace = T)

# initialize plot list:
joint_pdfs <- list()

for(t in 2:T){
  # t <- t+1
  # resample B from P(B|A)
  c_a <- cond_a %>% filter(A==as.numeric(gibbs[t-1,2]))
  gibbs[t,1] <- sample(support,prob = c_a$Freq,1)
  
  # resample A from P(A|B)
  c_b <- cond_b %>% filter(B==as.numeric(gibbs[t,1]))
  gibbs[t,2] <- sample(support,prob = c_b$Freq,1)

  gibbs

  
  # uncomment for visualization:
  joint_pdfs[[t]] <- gibbs[1:t,] %>% table
    
}

gibbs
prop.table(table(gibbs))
plot(table(gibbs))

# Visualize
for(i in 20:T){
  i <- i+1
  try(print(plot(joint_pdfs[[i]],main="Gibbs sampling")))
  Sys.sleep(0.1)
}

