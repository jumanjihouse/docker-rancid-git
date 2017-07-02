FROM alpine:3.6

# Use less to view man-pages since busybox `more' lacks the -s option.
ENV PAGER=less

# Install dependencies.
RUN apk add --no-cache \
      bash \
      expect \
      git \
      man man-pages \
      mdocml-apropos \
    && apk add --no-cache --virtual .builddeps \
      alpine-sdk \
      autoconf \
      automake \
      gcc \
      make \
    && adduser -D -s /bin/sh rancid \
    && \
    cd /usr/bin && \
    ln -s aclocal aclocal-1.14 && \
    ln -s automake automake-1.14 && \
    cd /root && \
    git clone https://github.com/dotwaffle/rancid-git.git && \
    cd rancid-git && \
    ./configure \
      --mandir=/usr/local/share/man \
      --sysconfdir=/etc/rancid \
      --bindir=/usr/bin/ \
      --enable-conf-install \
      && \
    make install && \
    rm -fr /root/rancid-git && \
    apk del --purge .builddeps

# Update mandb so `man -k rancid' works.
RUN makewhatis

# Container starts as user "rancid" in home dir.
USER rancid
WORKDIR /home/rancid

# Docker ignores files in these dirs.
VOLUME ["/home/rancid", "/usr/local/rancid/var"]

# `docker run' starts bash by default.
CMD ["/bin/sh"]
