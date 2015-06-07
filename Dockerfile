FROM alpine:3.2

# Install dependencies.
RUN apk add --update \
      alpine-sdk \
      autoconf \
      automake \
      expect \
      gcc \
      git \
      make \
      man man-pages \
    && rm -f /var/cache/apk/* \
    && adduser -D -s /bin/sh rancid

# Gross kludge.
RUN cd /usr/bin && \
    ln -s aclocal aclocal-1.14 && \
    ln -s automake automake-1.14

# Build and install rancid-git.
RUN cd /root && \
    git clone https://github.com/dotwaffle/rancid-git.git && \
    cd rancid-git && \
    ./configure --sysconfdir=/etc/rancid --bindir=/usr/libexec/rancid --enable-conf-install && \
    make install && \
    echo 'export PATH=$PATH:/usr/libexec/rancid/' >> /etc/profile.d/rancid_path.sh && \
    echo 'MANDATORY_MANPATH /usr/local/rancid/share/man' >> /etc/man.config && \
    echo 'MANDATORY_MANPATH /usr/local/rancid/share/man' >> /etc/man_db.conf

# Update mandb so `man -k rancid' works.
RUN makewhatis -w 2> /dev/null

# Container starts as user "rancid" in home dir.
USER rancid
WORKDIR /home/rancid

# Docker ignores files in these dirs.
VOLUME ["/home/rancid", "/usr/local/rancid/var"]

# `docker run' starts bash by default.
CMD ["/bin/sh"]
