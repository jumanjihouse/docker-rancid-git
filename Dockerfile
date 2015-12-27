FROM alpine:3.3

# Use less to view man-pages since busybox `more' lacks the -s option.
ENV PAGER=less

# Install dependencies.
RUN apk add --no-cache \
      alpine-sdk \
      autoconf \
      automake \
      bash \
      expect \
      gcc \
      git \
      make \
      man man-pages \
      mdocml-apropos \
    && adduser -D -s /bin/sh rancid

# Gross kludge.
RUN cd /usr/bin && \
    ln -s aclocal aclocal-1.14 && \
    ln -s automake automake-1.14

# Build and install rancid-git.
RUN cd /root && \
    git clone https://github.com/dotwaffle/rancid-git.git && \
    cd rancid-git && \
    ./configure \
      --mandir=/usr/local/share/man \
      --sysconfdir=/etc/rancid \
      --bindir=/usr/bin/ \
      --enable-conf-install \
      && \
    make install && \
    rm -fr /root/rancid-git

# Update mandb so `man -k rancid' works.
RUN makewhatis

# Container starts as user "rancid" in home dir.
USER rancid
WORKDIR /home/rancid

# Docker ignores files in these dirs.
VOLUME ["/home/rancid", "/usr/local/rancid/var"]

# `docker run' starts bash by default.
CMD ["/bin/sh"]
