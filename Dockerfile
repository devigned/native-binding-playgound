FROM library/debian:jessie

# remove several traces of debian python
RUN apt-get purge -y python.*

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        gcc \
        perl \
        make \
        git \
        openssh-client \
        xz-utils \
        zlib1g-dev \
        libssl-dev \
        g++ \
		libc6-dev \
		make \
		pkg-config \
        gnupg \
        wget \
        vim \
        default-jdk \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV EDITOR vim
ENV PYTHON_VERSION 3.6.1
ENV GOLANG_VERSION 1.8.1
ENV GOLANG_DOWNLOAD_URL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994

# gpg keys for python release managers
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6A45C816 36580288 7D9DC8D2 18ADD4FF A4135B38 A74B06BF EA5BBD71 ED9D77D5 E6DF025C AA65421D 6F5E1540 F73C700D 487034E5

RUN set -x \
    && mkdir -p /usr/src/python \
    && curl -SL "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz" -o python.tar.xz \
    && curl -SL "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz.asc" -o python.tar.xz.asc \
    && gpg --verify python.tar.xz.asc \
    && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
    && rm python.tar.xz* \
    && cd /usr/src/python \
    && ./configure --enable-shared --enable-unicode=ucs4 \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && rm -rf /usr/src/python \
    && cd /usr/local/bin \
    && ln -s easy_install-3.4 easy_install \
    && ln -s idle3 idle \
    && ln -s pip3 pip \
    && ln -s pydoc3 pydoc \
    && ln -s python3 python \
    && ln -s python-config3 python-config

RUN curl -fsSL "${GOLANG_DOWNLOAD_URL}" -o ./golang.tar.gz \
	&& echo "${GOLANG_DOWNLOAD_SHA256}  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz \
    && curl https://sh.rustup.rs -sSf | sh

RUN useradd -ms /bin/bash builder

RUN pip install --upgrade pip
COPY go-wrapper /usr/local/bin/

ENV USER_HOME /home/builder
ENV GOPATH ${USER_HOME}/go
RUN mkdir -p "${GOPATH}/src" "${GOPATH}/bin" && chmod -R 777 "${GOPATH}"

USER builder
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR ${USER_HOME}/binding/src
CMD bash