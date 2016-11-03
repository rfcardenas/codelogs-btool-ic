FROM ubuntu:xenial

MAINTAINER Ronald Fra.  (rfcardenas92@gmail.com)

RUN apt-get update


# Instar utilidades con menor riego de cambios
RUN \
    apt-get install -y \
    curl  \
    vim \
    git \
    zip \
    bzip2 \
    fontconfig \
    python \
    g++ \
    build-essential \
    wget \
    openjdk-8-jdk


# Instar utilidades con mayor riego de cambios
RUN \
 curl -sL https://deb.nodesource.com/setup_6.x | bash && \
  apt-get install -y nodejs maven
 

# Instalar utilidad es de Node  
RUN \
  npm install -g \
    yo \
    bower \
    gulp-cli \
    generator-jhipster


RUN apt-get -y install ruby-full sudo

RUN mkdir -p /root/.config/configstore && \ 
    mkdir -p /root/node_modules/ && \ 
    mkdir -p /root/deploy/ && \ 
    mkdir -p /root/scripts/ && \ 
    chmod g+rwx -R /root /root/.config /root/.config/configstore /root/node_modules/

#Check
RUN cd /root && ls -al && cd / 

#Heroku
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh


#Copy Resources
COPY ./heroku.sh /root/scripts
#COPY ./codelogs-server-simple /root/deploy



RUN groupadd codelogs && \
    useradd codelogs -s /bin/bash -m -g codelogs -G sudo && \
    echo 'codelogs:codelogs' |chpasswd && \
    chown codelogs /root -R



# Clean
RUN apt-get clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*




