FROM debian:jessie

ENV PYTHON_VERSION 3.6.0
ENV RVM_RUBY_VERSION ruby-2.3.3

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends xz-utils gcc g++ curl rsync fonts-ipafont-gothic ca-certificates libfontconfig zlib1g-dev libssl-dev && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc && \
    /bin/bash -l -c "rvm install $RVM_RUBY_VERSION --binary" && \
    /bin/bash -l -c "rvm use --default $RVM_RUBY_VERSION" && \
    curl -OL https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar xf Python-${PYTHON_VERSION}.tar.xz -C / && \
    cd /Python-${PYTHON_VERSION} && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    pip3 install sphinx sphinx_rtd_theme sphinxcontrib-blockdiag sphinxcontrib-seqdiag sphinx-autobuild && \
    mkdir /mirror && \
    apt-get purge -y --auto-remove g++ gcc make patch automake autoconf automake libtool bison && \
    apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  && \
    rm -rf /Python-${PYTHON_VERSION}* /tmp/*
    
WORKDIR /documents
VOLUME /documents

ADD watcher.rb /watcher.rb
ENV LANG C.UTF-8

CMD ["/bin/bash","-c","trap 'exit 0' INT; tail -f /dev/null"]