FROM google/cloud-sdk

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
  git \
  curl \
  mercurial \
  make \
  binutils \
  bison \
  gcc \
  build-essential \
  netcat \
  unzip

# Install gvm
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash && \
  source "$HOME/.gvm/scripts/gvm" && \
  source "$HOME/.bashrc" && \
  gvm listall && \
  gvm install go1.4 && \
  gvm use go1.4 && \
  export GOROOT_BOOTSTRAP=$GOROOT && \
  gvm install go1.6.2 && \
  gvm use go1.6.2 --default && \
  mkdir $GOPATH/bin && \
  curl https://glide.sh/get | sh

RUN echo 'alias ls="ls --color=auto"' >> ~/.bashrc
RUN echo 'alias ll="ls -halF"' >> ~/.bashrc

# Google App Engine
RUN wget -O appengine.zip https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.40.zip
RUN unzip -q appengine.zip -d /appengine && \ 
  rm -f appengine.zip
