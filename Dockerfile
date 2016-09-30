FROM rocker/r-apt
MAINTAINER "Michael Green" micke.green@gmail.com

## Install the rstan packages (and some close friends).
RUN install2.r --error \
    rstan \
    shinystan

## Install macroeconomics
RUN install2.r --error \
    Quandl
