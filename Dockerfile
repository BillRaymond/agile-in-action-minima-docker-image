FROM ubuntu:22.04

RUN echo "#################################################"
RUN echo "Get the latest APT packages"
RUN echo "apt-get update"
RUN apt-get update

RUN echo "#################################################"
RUN echo "Install Jekyll pre-requisites"
RUN echo "Partially based on https://gist.github.com/jhonnymoreira/777555ea809fd2f7c2ddf71540090526"
RUN echo "apt-get -y install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev"
RUN apt-get -y install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev apt-utils
RUN echo "ENV RBENV_ROOT /usr/local/src/rbenv"
ENV RBENV_ROOT /usr/local/src/rbenv
RUN echo "ENV RUBY_VERSION 3.1.2"
ENV RUBY_VERSION 3.1.2
RUN echo "ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH"
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH

RUN echo "#################################################"
RUN echo "Install rbenv to manage Ruby versions"
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
  && git clone https://github.com/rbenv/ruby-build.git \
    ${RBENV_ROOT}/plugins/ruby-build \
  && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo "#################################################"
RUN echo "Install ruby and set the global version"
RUN rbenv install ${RUBY_VERSION} \
  && rbenv global ${RUBY_VERSION}

RUN echo "#################################################"
RUN echo "Install Jekyll and bundler"
RUN echo "gem install jekyll bundler"
RUN gem install jekyll bundler --no-document

RUN echo "#################################################"
RUN echo "Install custom prerequisites for the Agile in Action website"
RUN echo "RUN apt-get install -y imagemagick"
RUN apt-get install -y imagemagick
