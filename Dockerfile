FROM ubuntu:14.04


# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get autoclean && apt-get -y update
RUN dpkg --configure -a



#---------- Python
RUN apt-get -y install --fix-missing python2.7 ipython-notebook
RUN apt-get download libgfortran3 liblapack3 python-numpy
RUN dpkg --force-depends -i libgfortran3*.deb && dpkg --force-depends -i liblapack3*.deb && dpkg --force-depends -i python-numpy_*.deb
RUN apt-get -f install -y
#---------- Utilities
RUN apt-get update && apt-get --fix-missing install -y \
    git \
    libxml2-dev \
    python \
    make \
    locales \
    python-pip \
    unzip \
    wget \
    curl \
    vim nano 

#---------- AWS Cli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
EXPOSE 8888
#ENTRYPOINT ["ipython", "notebook","--no-browser", "--ip='*'"]
