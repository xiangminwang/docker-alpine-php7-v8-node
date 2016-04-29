# Chose frolvlad/alpine-glibc for taking GNU C library back
FROM frolvlad/alpine-glibc
MAINTAINER xiangminwang <wang@xiangmin.net>

COPY /conf /opt/docker/

RUN set -x \
    # Fix root terminal
    && echo "export TERM=xterm" >> /root/.bashrc \
    # Fix "world" issue
    && echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    # Install some basic staff 
    && apk add --update bash git tar wget openssl python ruby ruby-irb ca-certificates curl ncurses \
    # Install heavy staff
    && apk add --update \
        v8 \
        nodejs \
        imagemagick \
    # Install linuxbrew
    && git clone https://github.com/Linuxbrew/linuxbrew.git /root/.linuxbrew \
    && source /opt/docker/brew.rc \
    # Install dependencies
    && brew install \
        homebrew/php/php70 \
        homebrew/php/php70-mcrypt \
        homebrew/php/php70-imagick \
        homebrew/php/php70-pdo-dblib \
        homebrew/php/php70-pdo-pgsql \
        homebrew/php/php70-mongodb \
        homebrew/php/php70-uuid \
        homebrew/php/php70-snmp \
        homebrew/php/php70-v8js \
    # Install gulp
    && npm install --global gulp \
    # Do some cleaning
    && rm -rf /var/cache/apk/*