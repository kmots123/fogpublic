#!/bin/bash
# fog-setup.sh
# pre-reqs
apt-get update && apt-get install -y apache2 bc build-essential cpp curl g++ gawk gcc genisoimage git gzip htmldoc isolinux lftp libapache2-mod-php7.4 libc6 libcurl4 liblzma-dev m4 mariadb-client mariadb-server net-tools nfs-kernel-server openssh-server php7.4 php7.4-bcmath php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql php7.4-mysqlnd tar tftp-hpa tftpd-hpa unzip vsftpd wget xinetd zlib1g && apt-get upgrade -y && apt-get clean
dpkg --configure -a
cd $HOME

# download project
wget https://github.com/FOGProject/fogproject/archive/1.5.9.tar.gz

# extract
tar vzxf $(ls | grep -i .tar.gz | awk '{print $1}')
export FOG_DIR=$(ls | grep fogproject | awk '{print $1}')

# install, -y indicates take defaults
$HOME/$FOG_DIR/bin/installfog.sh -yS
