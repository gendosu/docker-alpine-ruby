# alpine-ruby
#
# VERSION               0.0.1

FROM      gendosu/alpine-base:latest

MAINTAINER Gen Takahashi <gendosu@gmail.com>

ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV RUBY_VERSION 2.3.0
ENV CONFIGURE_OPTS --disable-install-doc

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

RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git /usr/local/rbenv \
&&  git clone --depth 1 https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
&&  git clone --depth 1 git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
&&  /usr/local/rbenv/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install $RUBY_VERSION \
&&  rbenv global $RUBY_VERSION

RUN gem install bundler

