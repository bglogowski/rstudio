#!/bin/bash
apt-get update -y

# install aws tools
apt-get install -y awscli build-essential r-base gdebi-core


wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.1-372-amd64.deb
sudo gdebi --non-interactive rstudio-server-2021.09.1-372-amd64.deb

# install R dependencies
#chmod 777 /tmp/libraries.R
#Rscript /tmp/libraries.R

# change the R studio password using the parameter passed
#echo "changing rstudio password to $1"
#echo "rstudio:$1" | chpasswd
