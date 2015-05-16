FROM rocker/rstudio

MAINTAINER Rodrigo Martell <rodrigo.martell@gmail.com>

# IPoptr envrionment directory
ENV IPOPTR_DIR=/CoinIpopt/build/Ipopt/contrib

# Give the user root access, go on!
RUN echo "$USER ALL = NOPASSWD: ALL" >> /etc/sudoers && \

##################
# Download ipoptr source
# See these nasty files: 
# http://www.coin-or.org/Ipopt/documentation/node10.html
##################
    wget http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.3.tgz && \
    gunzip Ipopt-3.12.3.tgz && \
    tar -xvf Ipopt-3.12.3.tar && \
    rm -rf Ipopt-3.12.3.tar && \
    mv Ipopt-3.12.3 CoinIpopt && \
    cd CoinIpopt && \

# Downloading BLAS, LPACK, and ASL
    cd ThirdParty/Blas && \
        ./get.Blas && \
    cd ../Lapack && \
        ./get.Lapack && \
    cd ../ASL && \
        ./get.ASL && \

# Download HSL Subroutines (need a license and academic email, seriious?!)
# Skip for now: http://www.coin-or.org/Ipopt/documentation/node13.html#SECTION00043100000000000000

# Downloading MUMPS Linear Solver
    cd ../Mumps && \
        ./get.Mumps && \

# Get METIS
    cd ../Metis && \
        ./get.Metis && \

##################
# Compile ipoptr
##################
    cd ../../ && \
    mkdir build && \
    cd build && \
    ../configure -with-pic && \
    make -j3 && \
    make test && \
    make install && \

##################
# Pre-install ipoptr
##################
    echo "install.packages('/CoinIpopt/build/Ipopt/contrib/RInterface', repos=NULL, type='source')" \
    >> installIpoptrPackage.R && \
    r installIpoptrPackage.R && \
    rm installIpoptrPackage.R

# Default CMD from 
# https://github.com/rocker-org/rocker/blob/master/rstudio/Dockerfile
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]