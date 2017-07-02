rancid-git on Alpine Linux
==========================

Overview
--------

Provide [`rancid`](http://www.shrubbery.net/rancid/),
the Really Awesome New Cisco confIg Differ,
with git support in a smallish container.
RANCID monitors a device's configuration, including software and hardware,
and uses CVS, Subversion, or Git to maintain history of changes.


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
