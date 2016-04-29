FROM webdevops/php:alpine-3-php7
MAINTAINER xiangminwang <wang@xiangmin.net>

# v8js required this variable
ENV NO_INTERACTION 1

# Install v8 & nodejs
RUN /usr/local/bin/apk-install \
        v8 \
        nodejs

# Install v8js
RUN ln -s /usr/bin/phpize7 /usr/bin/phpize && \
    git clone https://github.com/phpv8/v8js.git /tmp/v8js && \
    cd /tmp/v8js && phpize && ./configure --with-v8js=/usr/local && \
    make all test install && echo extension=v8js.so > /etc/php7/conf.d/03-v8js.ini

# Install gulp
RUN npm install gulp -g