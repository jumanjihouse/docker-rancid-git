rancid-git on CentOS 7
======================

Overview
--------

Demonstrate one way to build `rancid-git` on CentOS.


Related projects
----------------

* [rancid-git](https://github.com/dotwaffle/rancid-git)
* [docker-rancid-git-centos6](https://github.com/jumanjihouse/docker-rancid-git-centos6)


How-to
------

Build this image locally on a host with Docker:

    git clone https://github.com/jumanjihouse/docker-rancid-git.git
    cd docker-rancid-git
    docker build --rm -t rancid-git:centos7 .

Run a container with bash from the built image:

    docker run --rm -it rancid-git:centos7


License
-------

See LICENSE in this repo.
