# R Bayesian
This is the R Bayesian Data Science Toolkit for deployment purposes.

[![Build Status](https://travis-ci.org/DoktorMike/r-bayesian.svg?branch=master)](https://travis-ci.org/DoktorMike/r-bayesian)

# Quick start

To start using this container and playing around with it you should start by pulling it into your machine and opening an interactive bash session by writing

```bash
sudo docker pull drmike/r-bayesian
sudo docker run -it drmike/r-bayesian bash
```

in your terminal.

# About this container

So why did I go through the trouble of creating this container? Well first off I didn't find a container for deploying Bayesian applications using R that suited my needs. Thus I created this one with the sole purpose of having a small barebone platform on which I could build many different Bayesian applications in R. When I say Bayesian I mean Bayesian models fitted using Stan. According to me Hamiltonian Markov Chain Monte Carlo is currently the best option we have for building general Bayesian models.
