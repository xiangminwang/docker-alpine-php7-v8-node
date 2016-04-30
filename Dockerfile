FROM webdevops/base-app:ubuntu-14.04
MAINTAINER xiangminwang <wang@xiangmin.net>

ENV WEB_DOCUMENT_ROOT  /app
ENV WEB_DOCUMENT_INDEX index.php
ENV WEB_ALIAS_DOMAIN   *.vm

ADD sources.list /etc/apt/sources.list

RUN sudo apt-get update \

    # Install dependencies
    && sudo apt-get install -y build-essential curl git python-setuptools ruby \

    # Install linuxbrew
    && useradd -m -s /bin/bash linuxbrew \
    && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && git clone https://github.com/Linuxbrew/linuxbrew.git /home/linuxbrew/.linuxbrew \
    && chown -R linuxbrew: /home/linuxbrew/.linuxbrew

USER linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
ENV SHELL=/bin/bash
RUN brew install \
    # Install heavy staff
    v8 \
    imagemagick \
    homebrew/php/php70 \
    homebrew/php/php70-mcrypt \
    homebrew/php/php70-imagick \
    homebrew/php/php70-pdo-dblib \
    homebrew/php/php70-pdo-pgsql \
    homebrew/php/php70-mongodb \
    homebrew/php/php70-uuid \
    homebrew/php/php70-snmp \
    homebrew/php/php70-v8js \
    composer \
    nodejs \
    # Install gulp
    && npm install --global gulp

USER root
COPY conf/ /opt/docker/
RUN bash /opt/docker/bin/control.sh provision.role.bootstrap homebrew-php \
    && bash /opt/docker/bin/bootstrap.sh

EXPOSE 9000

CMD ["supervisord"]