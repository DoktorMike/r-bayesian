# R Bayesian
This is the R Bayesian Data Science Toolkit for deployment purposes.

## Docker image

[![](https://images.microbadger.com/badges/image/drmike/r-bayesian.svg)](https://microbadger.com/images/drmike/r-bayesian "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/drmike/r-bayesian.svg)](https://microbadger.com/images/drmike/r-bayesian "Get your own version badge on microbadger.com")

## Build

[![Build Status](https://travis-ci.org/DoktorMike/r-bayesian.svg?branch=master)](https://travis-ci.org/DoktorMike/r-bayesian)

## Quick start

To start using this container and playing around with it you should start by pulling it into your machine and opening an interactive bash session by writing

```bash
sudo docker pull drmike/r-bayesian
sudo docker run -it drmike/r-bayesian bash
```

in your terminal.

You can also make sure that you run the OpenCPU server inside the docker and test the stupidweather prediction api included in this release.

```bash
docker run -d -p 80:80 -p 443:443 -p 8004:8004 drmike/r-bayesian
curl http://localhost:8004/ocpu/library/stupidweather/R/predictweather/json -H "Content-Type: application/json" -d '{"n":6}'
```

which on windows most likely have to be:

```bash
curl http://localhost/ocpu/library/stupidweather/R/predictweather/json -Method Post
```

since curl is slightly different there.

Be sure to replace the ip number with the ip number you received when you started the docker container. On linux systems this can be referred to as localhost. On windows it will be a specific IP. On Windows 10 I think localhost also works.

If you want to play around with the interface you can open up your browser and surf to http://localhost/ocpu/test/ where again the IP number has to be updated to your specific IP that you got when starting the docker.

## Worked examples

This code represents two ways of getting the weather prediction for the next 6 days.

```bash
# Posting parameters as JSON
curl http://localhost:8004/ocpu/library/stupidweather/R/predictweather/json -H "Content-Type: application/json" -d '{"n":6}'

# Same thing using post and afterwards get. Remember to replace the id with the output you get
curl http://localhost:8004/ocpu/library/stupidweather/R/predictweather -d 'n=6'
curl http://localhost:8004/ocpu/tmp/x036827416d/stdout/text
```

We can also upload data and look at the summaries:

```bash
# Upload local file mydata.csv
curl http://localhost:8004/ocpu/library/utils/R/read.csv -F "file=@mydata.csv"

# Replace session id with returned one above
curl http://localhost:8004/ocpu/tmp/x067b4172/R/.val/print
curl http://localhost:8004/ocpu/library/base/R/summary -d "object=x067b4172"
```

## About this container

So why did I go through the trouble of creating this container? Well first off I didn't find a container for deploying Bayesian applications using [R](https://www.r-project.org) that suited my needs. Thus I created this one with the sole purpose of having a small barebone platform on which I could build many different Bayesian applications in R. When I say Bayesian I mean Bayesian models fitted using [Stan](http://mc-stan.org). According to me Hamiltonian Markov Chain Monte Carlo is currently the best option we have for building general Bayesian models.

I borrowed heavily from the [Rocker](https://hub.docker.com/u/rocker) repository as I think they built some really nice containers. Dirk and the others, keep up the great work. ;)

Another thing I've added to the mix since we are talking about deployment is [OpenCPU](https://www.opencpu.org) which basically allows R to be called through javascript libraries and exposing the power of R directly on the web. Note that this is very different than Shiny as it doesn't require you to learn specific frameworks or syntaxes. It's just R piped through AJAX.
