@test "image exists" {
  run docker images --format='{{ .Repository }}' rancid
  [[ ${output} =~ ^rancid$ ]]
}

@test "rancid -h shows help" {
  output=$(docker-compose run help 2> /dev/null || :)
  [[ ${output} =~ ^rancid.*-.*h ]]
}
