# This dockerfile builds with either centos6 or centos7.
# Just choose which one with a relevant "FROM" line.

# FROM centos:centos6
FROM centos:centos7

# Allow rpms to install docs.
RUN sed -i '/tsflags=nodocs/d' /etc/yum.conf

# Ensure pre-installed packages are up-to-date.
RUN yum -y update; yum clean all
ONBUILD RUN yum -y update; yum clean all

# Install dependencies.
RUN yum -y install epel-release; yum clean all
RUN yum -y install \
    autoconf \
    automake \
    expect \
    gcc \
    git \
    make \
    man man-pages man-db \
    ; yum clean all

# Gross kludge.
RUN cd /usr/bin; \
    ln -s aclocal aclocal-1.14; \
    ln -s automake automake-1.14

# Build and install rancid-git.
RUN cd /root; \
    git clone https://github.com/dotwaffle/rancid-git.git; \
    cd rancid-git; \
    ./configure --sysconfdir=/etc/rancid --bindir=/usr/libexec/rancid --enable-conf-install; \
    make install; \
    echo 'export PATH=$PATH:/usr/libexec/rancid/' >> /etc/profile.d/rancid_path.sh; \
    echo 'MANDATORY_MANPATH /usr/local/rancid/share/man' >> /etc/man.config; \
    echo 'MANDATORY_MANPATH /usr/local/rancid/share/man' >> /etc/man_db.conf

# Update mandb so `man -k rancid' works.
RUN makewhatis -w 2> /dev/null || mandb -q $(manpath)

# Solution for 'ping: icmp open socket: Operation not permitted'.
# `docker run --cap-add all --rm -it jumanjiman/rancid-git' does not solve it.
# See https://bugzilla.redhat.com/show_bug.cgi?id=1142311
RUN chmod u+s /usr/bin/ping

# Container starts as user "rancid" in home dir.
RUN useradd rancid
USER rancid
WORKDIR /home/rancid

# Docker ignores files in these dirs.
VOLUME /home/rancid
VOLUME /usr/local/rancid/var

# `docker run' starts bash by default.
CMD ["/bin/bash"]
