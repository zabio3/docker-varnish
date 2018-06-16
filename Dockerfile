ARG VARNISH_IMAGE_BASE="ubuntu"
ARG VARNISH_IMAGE_TAG="xenial"

FROM ${VARNISH_IMAGE_BASE}:${VARNISH_IMAGE_TAG}
LABEL maintainer="zabio3 <ttmsk1192@gmail.com>"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        make \
        automake \
        autotools-dev \
        libedit-dev \
        libjemalloc-dev \
        libncurses-dev \
        libpcre3-dev \
        libtool \
        pkg-config \
        python-docutils \
        python-sphinx \
        graphviz \
        autoconf-archive \
        git \
        ca-certificates

RUN cd /usr/src \
    && git clone https://github.com/varnishcache/varnish-cache \
    && cd varnish-cache \
    && sh autogen.sh \
    && sh configure \
    && make \
    && make install

ADD default.vcl /etc/varnish/default.vcl
ADD start.sh /start.sh

ENV VARNISH_PORT=80

EXPOSE ${VARNISH_PORT}

CMD ["/start.sh"]