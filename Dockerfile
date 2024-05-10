FROM ubuntu:22.04

RUN echo "#################################################"
RUN echo "This Docker container includes everything for:"
RUN echo "Building the Agile in Action website"
RUN echo "Running scripts in support of building the site"
RUN echo "Running scripts in support of building GPT content"


RUN echo "#################################################"
RUN echo "Update APT packages"
RUN apt-get update

RUN echo "#################################################"
RUN echo "Install Jekyll pre-requisites"
RUN echo "Partially based on https://gist.github.com/jhonnymoreira/777555ea809fd2f7c2ddf71540090526"
RUN apt-get -y install \
    git \
    curl \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm6 \
    libgdbm-dev \
    libdb-dev \
    apt-utils \
    jq

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

RUN echo "#################################################"
RUN echo "NEW"
RUN echo "#################################################"

RUN echo "#################################################"
RUN echo "Prevent timezone Python prompt"
ENV TZ=America/Los_Angeles \
DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN echo "#################################################"
RUN echo "Install Python pre-requisites"
RUN apt-get install -y \
software-properties-common \
libhdf5-dev

RUN echo "#################################################"
RUN echo "Install Python and required tooling"
RUN apt-get install -y python3 \
      python3-pip \
      python3-ipykernel \
      libopencv-dev \
      python3-opencv \
      curl

RUN echo "#################################################"
RUN echo "Upgrade PIP (Python's package manager)"
RUN pip install --upgrade pip

RUN echo "#################################################"
RUN echo "Install GitHub Action workflow tools"
RUN pip install --no-cache-dir qrcode[pil] && \
pip install --no-cache-dir --upgrade pillow

RUN pip install --no-cache-dir python-pptx \
openai \
pyyaml \
h5py \
tabulate \
pandoc \
markdown2 \
pdfkit \
beautifulsoup4 \
pydub \
ffprobe

RUN apt-get install -y \
wkhtmltopdf \
ffmpeg

RUN echo "#################################################"
RUN echo "Clear caches to save space"
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find / -type d -name __pycache__ -prune -exec rm -rf {} \;
