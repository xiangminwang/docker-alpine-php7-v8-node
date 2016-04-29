FROM alpine:3.3
MAINTAINER xiangminwang <wang@xiangmin.net>

RUN set -x \
    # Fix root terminal
    && echo "export TERM=xterm" >> /root/.bashrc \
    # Add testing
    && echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    # Install some basic staff 
    && apk add --update bash git wget curl shadow ca-certificates \
    # Install linuxbrew
    && git clone https://github.com/Linuxbrew/linuxbrew.git ~/.linuxbrew \
    && echo "export PATH=$HOME/.linuxbrew/bin:$PATH" >> /root/.bashrc \
    && echo "export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH" >> /root/.bashrc \
    && echo "export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH" >> /root/.bashrc \
    # Install dependencies
    && brew install \
        v8 \
        node \
        imagemagick \
        homebrew/php/php70 \
        homebrew/php/php70-mcrypt \
        homebrew/php/php70-imagick \
        homebrew/php/php70-pdo-dblib \
        homebrew/php/php70-pdo-pgsql \
        homebrew/php/php70-memcached \
        homebrew/php/php70-mongodb \
        homebrew/php/php70-redis \
        homebrew/php/php70-uuid \
        homebrew/php/php70-snmp \
        homebrew/php/php70-v8js \
    # Install gulp
    && npm install --global gulp \
    # Do some cleaning
    && rm -rf /var/cache/apk/*