#!/usr/bin/env bats

setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # ... the remaining setup is unchanged

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
}

@test "support latest versions" {
  run ./check_inputs.sh "latest" "latest" "1G"
  assert_success
  echo -e "::notice::Using the latest IG Publisher\n::notice::Using the latest SUSHI\n::notice::Setting Java max heap memory to 1G" | assert_output
}

@test "disable sushi" {
  run ./check_inputs.sh "latest" "false" "512m"
  assert_success
  echo -e "::notice::Using the latest IG Publisher\n::notice::Not using SUSHI\n::notice::Setting Java max heap memory to 1G" | assert_output
}

@test "error: show error and exit with 22" {
  bats_require_minimum_version 1.5.0
  run -22 ./check_inputs.sh "false" "1.2.3" "1G"
  assert_output "::error::Bad IG Publisher version"
}

@test "error: invalid java heap memory" {
  bats_require_minimum_version 1.5.0
  run -22 ./check_inputs.sh "1.2.3" "1.2.3" "0"
  assert_output --partial "::error::Invalid Java max heap memory value"
}
