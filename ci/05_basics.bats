################################################################################
# This file is used by BATS in the test harness invoked from "ci/test".
# See https://github.com/bats-core/bats-core for BATS syntax.
################################################################################

@test "image exists" {
  run docker images --format='{{ .Repository }}' rancid
  [[ ${output} =~ ^rancid$ ]]
}

@test "tagged image exists - optimistic" {
  run docker images --format='{{ .Repository }} {{ .Tag }}' jumanjiman/rancid:latest
  [[ ${output} =~ ^jumanjiman/rancid\ latest$ ]]
}

@test "tagged image exists - pessimistic" {
  run docker images --format='{{ .Tag }}' jumanjiman/rancid
  [[ ${output} =~ ^${RANCID_VERSION}-${RANCID_RELEASE}_.*_git_.* ]]
}

@test "rancid -h shows help" {
  output=$(docker-compose run help 2> /dev/null || :)
  [[ ${output} =~ rancid.*-.*h ]]
}

@test "rancid is the expected version" {
  output=$(docker-compose run version 2> /dev/null)
  [[ ${output} =~ rancid\ +${RANCID_VERSION} ]]
}

@test "ci-build-url label is present" {
  if [[ -z ${CIRCLE_BUILD_URL} ]]; then
    skip "This test runs only on circleci"
  fi
  run docker inspect \
      -f '{{ index .Config.Labels "io.github.jumanjiman.ci-build-url" }}' \
      jumanjiman/rancid
  [[ ${output} =~ circleci.com ]]
}
