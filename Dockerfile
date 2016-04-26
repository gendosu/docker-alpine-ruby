# alpine-ruby
#
# VERSION               0.0.1

FROM      gendosu/alpine-base:latest

MAINTAINER Gen Takahashi <gendosu@gmail.com>

ENV RBENV_ROOT /usr/local/rbenv \
&&  PATH ${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:$PATH \
&&  RUBY_VERSION 2.3.0 \
&&  CONFIGURE_OPTS --disable-install-doc

RUN apk add --update \
    linux-headers \
    imagemagick-dev \
    qt-webkit \
    xvfb \
    libffi-dev \
    mariadb-dev \
    mysql-client \
    libffi-dev \
&&  rm -rf /var/cache/apk/*

RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git ${RBENV_ROOT} \
&&  git clone --depth 1 https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
&&  git clone --depth 1 git://github.com/jf/rbenv-gemset.git ${RBENV_ROOT}/plugins/rbenv-gemset \
&&  ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install $RUBY_VERSION \
&&  rbenv global $RUBY_VERSION

RUN gem install bundler

