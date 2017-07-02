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
  [[ ${output} =~ ^${VERSION}-${RELEASE}_.*_git_.* ]]
}

@test "rancid -h shows help" {
  output=$(docker-compose run help 2> /dev/null || :)
  [[ ${output} =~ ^rancid.*-.*h ]]
}

@test "rancid is the expected version" {
  output=$(docker-compose run version 2> /dev/null)
  [[ ${output} =~ ^rancid\ +${VERSION} ]]
}
