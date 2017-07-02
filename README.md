rancid-git on Alpine Linux
==========================

Overview
--------

Demonstrate one way to build `rancid-git`.


Related projects
----------------

* [rancid-git](https://github.com/dotwaffle/rancid-git)
* [docker-rancid-git-centos6](https://github.com/jumanjihouse/docker-rancid-git-centos6)


How-to
------

Build this image locally on a host with Docker:

    git clone https://github.com/jumanjihouse/docker-rancid-git.git
    cd docker-rancid-git
    ci/build

Run a container with bash from the built image:

    docker run --rm -it rancid


License
-------

See LICENSE in this repo.
