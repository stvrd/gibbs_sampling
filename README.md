# Gibbs sampling
Understand Gibbs sampling (based on https://www.youtube.com/watch?v=ER3DDBFzH2g)

- The aim of Gibbs sampling is to approximate a joint pdf by sampling from conditional pdfs
- The algorithm is guaranteed to converge asymptotically on the true joint pdf
- The Gibbs algorithm is a special case of the Metropolis algorithm
- We do not reject samples, therefore it is more efficient
- However, the conditional pdfs need to be known
