Install FOG prereqs:
  pkg.installed:
    - pkgs:
      - apache2
      - bc
      - build-essential
      - cpp
      - curl
      - g++
      - gawk
      - gcc
      - genisoimage
      - git
      - gzip
      - htmldoc
      - isolinux
      - lftp
      - libapache2-mod-php7.4
      - libc6
      - libcurl4
      - liblzma-dev
      - m4
      - mariadb-client
      - mariadb-server
      - net-tools
      - nfs-kernel-server
      - openssh-server
      - php7.4
      - php7.4-bcmath
      - php7.4-cli
      - php7.4-curl
      - php7.4-fpm
      - php7.4-gd
      - php7.4-json
      - php7.4-ldap
      - php7.4-mbstring
      - php7.4-mysql
      - tar
      - tftp-hpa
      - tftpd-hpa
      - unzip
      - vsftpd
      - wget
      - xinetd
      - zlib1g
  
Clone FOG repo:
  git.cloned:
    - name: https://github.com/fogproject/fogproject.git
    - target: /opt/fogproject-master

Install FOG:
  cmd.run:
    - name: ./installfog.sh -yS
    - cwd: /opt/fogproject-master/bin
    - onchanges:
      - git: Clone FOG repo
