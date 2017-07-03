FROM alpine:3.6

# Use less to view man-pages since busybox `more' lacks the -s option.
ENV PAGER=less

ARG VERSION
ARG RELEASE

# Install dependencies.
RUN apk add --no-cache \
      bash \
      expect \
      git \
      man man-pages \
      mdocml-apropos \
      perl \
      perl-socket6 \
      "rancid=${VERSION}-${RELEASE}" \
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

# These args and labels go last in the Dockerfile so
# we do not bust the docker build cache for local builds.
ARG CI_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF

LABEL \
    io.github.jumanjiman.ci-build-url=${CI_BUILD_URL} \
    io.github.jumanjiman.version=${VERSION}-${RELEASE} \
    io.github.jumanjiman.build-date=${BUILD_DATE} \
    io.github.jumanjiman.vcs-ref=${VCS_REF} \
    io.github.jumanjiman.license="MIT" \
    io.github.jumanjiman.docker.dockerfile="/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-rancid-git.git"
