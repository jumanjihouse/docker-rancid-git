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


### Test

We use circleci to build, test, and publish the image to Docker hub.
We use [BATS](https://github.com/sstephenson/bats) to run the test harness.

Run the tests locally:

    ci/test

BATS output resembles:

    ✓ image exists
    ✓ tagged image exists - optimistic
    ✓ tagged image exists - pessimistic
    ✓ rancid -h shows help
    ✓ rancid is the expected version
    - ci-build-url label is present (skipped: This test runs only on circleci)

    6 tests, 0 failures, 1 skipped


License
-------

See [`LICENSE`](LICENSE) in this repo.
