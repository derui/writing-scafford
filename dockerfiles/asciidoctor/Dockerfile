FROM debian:jessie

ENV NODE_VERSION v6.9.4
ENV RVM_RUBY_VERSION ruby-2.3.3

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl rsync fonts-migmix ca-certificates libfontconfig && \
    curl -L git.io/nodebrew | perl - setup && \
    export PATH=$HOME/.nodebrew/current/bin:$PATH && \
    echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.bashrc && \
    nodebrew install-binary $NODE_VERSION && \
    nodebrew use $NODE_VERSION && \
    npm install -g mermaid && \
    npm cache clean && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc && \
    /bin/bash -l -c "rvm install $RVM_RUBY_VERSION --binary" && \
    /bin/bash -l -c "rvm use --default $RVM_RUBY_VERSION && \
        gem install --no-rdoc --no-ri asciidoctor asciidoctor-diagram guard guard-shell io-console guard-livereload rack rack-livereload eventmachine && \
        gem install --no-ri --no-rdoc --pre asciidoctor-pdf && \
        gem cleanup" && \
    mkdir /mirror && \
    apt-get purge -y --auto-remove g++ gcc make patch automake autoconf automake libtool bison && \
    apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  && \
    rm -rf /tmp/*
    
RUN mkdir -p /usr/local/share && cd /usr/local/share \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar xj \
  && mv phantomjs-2.1.1-linux-x86_64 phantomjs \
  && ln -s /usr/local/share/phantomjs/bin/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

WORKDIR /documents
VOLUME /documents

ADD watcher.rb /watcher.rb
ENV LANG C.UTF-8

CMD ["/bin/bash","-c","trap 'exit 0' INT; tail -f /dev/null"]