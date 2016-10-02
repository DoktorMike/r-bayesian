FROM ubuntu:xenial

## This handle reaches Mike
MAINTAINER "Michael Green" micke.green@gmail.com

ARG DEBIAN_FRONTEND=noninteractive

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker && mkdir /home/docker && chown docker:docker /home/docker && addgroup docker staff

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common ed less locales vim-tiny wget \
		ca-certificates libcurl4-openssl-dev libssl-dev \
  && add-apt-repository --enable-source --yes "ppa:marutter/rrutter" \
	&& add-apt-repository --enable-source --yes "ppa:marutter/c2d4u"

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.utf8 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# Now install R and littler, and create a link for littler in /usr/local/bin
# Also set a default CRAN repo, and make sure littler knows about it too
# Note 1: we need wget here as the build env is too old to work with libcurl (we think, precise was)
# Note 2: r-cran-docopt is not currently in c2d4u so we install from source
RUN apt-get update && apt-get install -y --no-install-recommends \
    littler r-base r-base-dev r-recommended r-cran-stringr r-cran-rcpp \
	&& echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
	&& install.r docopt \
	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*

## Install the rstan packages (and some close friends).
RUN install2.r --error rstan

## Install macroeconomics
RUN install2.r --error Quandl

## Install OpenCPU
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:opencpu/opencpu-1.6 && \
  apt-get update && \
  apt-get install -y opencpu

# Apache ports
EXPOSE 80
EXPOSE 443
EXPOSE 8004

# Define default command.
CMD service opencpu restart && tail -F /var/log/opencpu/apache_access.log
