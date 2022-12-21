## set R version (https://hub.docker.com/r/rocker/verse/tags)
FROM rocker/verse:3.6.2

## set up directories
RUN mkdir /output \
    && mkdir /analysis \
    && mkdir /Data
COPY Packages /analysis
COPY Paper /analysis
COPY Data /Data
COPY CRANpackages.txt /analysis
WORKDIR /analysis

## install R packages from CRAN the last day of the specified R version;
## - add packages required for the analysis to the CRANpackages.txt file
## - increase ncpus when installing many packages (and more than 1 CPU available)
RUN install2.r --error --skipinstalled --ncpus -4 \
    `cat CRANpackages.txt`

## install non-CRAN R packages
RUN R CMD INSTALL biostatUZH_1.8.0.tar.gz

## compile Rnw to PDF
CMD make pdf sup1 sup2 \
    && mv pfors.pdf pfors-sup1.pdf pfors-sup2.pdf /output/ \
    ## change file permission of output files
    && chmod -R 777 /output/
