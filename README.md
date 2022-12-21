# Probabilistic forecasting of replication studies

This repository contains code and data to reproduce the accepted manuscript of
the paper

Pawel, S., Held. L. (2020). Probabilistic forecasting of replication studies.
PLOS ONE. 15(4):e0231416.
[doi:10.1371/journal.pone.0231416](https://doi.org/10.1371/journal.pone.0231416)

## Reproducing the results

We offer two ways to reproduce the results

### 1. Reproduction with local computational environment (requires R and LaTeX)

First install the required R packages by running in a shell from the root
directory of the repository

``` sh
## packages
R -e 'install.packages(read.delim("CRANpackages.txt", header = FALSE)[,1])'
cd packages
R CMD INSTALL biostatUZH_1.8.0.tar.gz
```

Then run from the root directory of the repository

``` 
make local
```

this should reproduce all analyses and output the main manuscript and the two
supplements.

Although our analysis depends on only few dependencies, this approach may lead
to different results (or not even compile successfully) in the future if R or an
R package dependency changes. The R and R package versions which were used in
our analysis can be seen in the output of the sessionInfo command at the bottom
of the manuscript in the snapshot of the GitHub repository at the time of
submission.

### 2. Reproduction within Docker container (requires Docker with root rights)

Run in a shell from the root directory of the repository

```
make docker
```

this should output the main manuscript and the two supplements. The Docker
approach takes a bit longer but reruns our analyses in a Docker container which
encapsulates the computational environment (R and R package versions) that was
used in the original analysis. The only way this approach could become
irreproducible is when the [rocker/verse](https://hub.docker.com/r/rocker/verse)
base image becomes unavailable and/or the MRAN snapshot of CRAN becomes
unavailable.

