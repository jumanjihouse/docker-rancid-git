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

### Pull an already-built image

    docker pull jumanjiman/rancid


### Tags

We provide multiple tags:

* optimistic:  `jumanjiman/rancid:latest`
* pessimistic: `jumanjiman/rancid:<version>_<builddate>_git_<hash>`

Example:

    jumanjiman/rancid:3.6.1-r0_20170702T1659_git_6fead99
                      ^^^^^^^^ ^^^^^^^^^^^^^     ^^^^^^^
                          |         |              |
                          |         |              +--> hash from this git repo
                          |         |
                          |         +-----------------> build date and time
                          |
                          +---------------------------> version of rancid


### Build locally

Build this image locally on a host with Docker:

    git clone https://github.com/jumanjihouse/docker-rancid-git.git
    cd docker-rancid-git
    ci/build

Run a container with bash from the built image:

    docker run --rm -it jumanjiman/rancid


License
-------

See LICENSE in this repo.
