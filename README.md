# Docker-ipoptr

This is a simple repo that builds on [rocker](https://github.com/rocker-org/rocker) to build and add [ipoptr](http://www.ucl.ac.uk/~uctpjyy/downloads/ipoptr.pdf). It was built for my friend Simone, hence the username and password.

Everything (R, RStudio, ipoptr) is contained in this image. In addition, the directory `my-r-code` is mounted into the container at run time, so remember to save stuff there when working in R Studio.

## Requirements

1. [Docker](https://docs.docker.com/installation/)

1. [docker-compose]() (optional, but handy if you can get).

## Firing up (option A - no docker-compose)

```
[you@your-project]: mkdir my-r-code # place all your code here
[you@your-project]: docker run -p 80:8787 -hostname: simoner -e ROOT=TRUE USER=simoner PASSWORD=boom -v $(pwd)/my-r-code:/my-r-code -d coderigo/docker-ipoptr
```

## Firing up (option B)


## Get into it

Now travel to the IP address reported by `echo $DOCKERHOST`, log in with the username `simoner` and password `boom` and begin developing. Your scripts (which you'll version control with git, right?) within R studio will be available by setting your working directory to `setwd("/my-r-code")`, even after killing the container.

## Example.

Look in this directory's `my-r-code` subdirectory for a simple script to test things out.

```r
setwd("/my-r-code/")
source("testIpoptr.R")
```