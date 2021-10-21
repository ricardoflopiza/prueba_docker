 FROM openanalytics/r-base
 MAINTAINER RPS 
# 01-09-2021 . OBSJCA este archivo DOKERFILE, es para la ultima version (version2) de la app de calidad entregada el dia 31-08-2021.
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1 \
    build-essential \
    cmake \
    git \
    libbamtools-dev \
    libboost-dev \
    libboost-iostreams-dev \
    libboost-log-dev \
    libboost-system-dev \
    libboost-test-dev \
    libxml2-dev \
    libz-dev \
    curl \
    libarmadillo-dev \
    && rm -rf /var/lib/apt/lists/*
# system library dependency for the euler app
RUN apt-get update && apt-get install -y \
    libmpfr-dev \
    && rm -rf /var/lib/apt/lists/*
# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"
# install dependencies Shiny_Calidad App
RUN R -e "install.packages(c('devtools','shinyFeedback', 'calidad', 'shiny', 'haven', 'labelled', 'dplyr', 'openxlsx', 'sjmisc',  'readxl','survey', 'shinyWidgets', 'rlang', 'kableExtra', 'shinycssloaders', 'readr', 'shinybusy', 'shinyalert', 'writexl', 'shinyjs', 'tibble', 'plotly'), repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('inesscc/calidad')"
RUN mkdir /root/calidadv2
COPY R /root/calidadv2
COPY Rprofile.site /usr/lib/R/etc/

CMD ["R","-e", "shiny::runApp('/root/calidadv2')"]
#CMD ["R", "-e", "shiny::runApp('/root/calidadv2', host='0.0.0.0', port=3838)"]

EXPOSE 3838
