FROM alpine:3.11

# Use less to view man-pages since busybox `more' lacks the -s option.
ENV PAGER=less

# Install dependencies.
RUN apk add --no-cache \
      bash \
      expect \
      git \
      man man-pages \
      mdocml-apropos \
      openssh-client \
      perl \
      perl-socket6 \
      rancid \
      rancid-doc \
      && \
    :

# Update mandb so `man -k rancid' works.
RUN makewhatis

# Container starts as user "rancid" in home dir.
USER rancid
WORKDIR /var/rancid

# Docker ignores files in these dirs.
VOLUME ["/var/rancid", "/usr/local/rancid/var"]

# `docker run' starts bash by default.
CMD ["/bin/sh"]
