#!/usr/bin/env bats

setup() {
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
  ./check_inputs.sh "latest" "latest"
  assert_success
  assert_output "::notice::Using the latest IG Publisher\n::notice::Using the latest SUSHI"
}

@test "disable sushi" {
  ./check_inputs.sh ./check_inputs.sh "latest" "false"
  assert_success
  assert_output "::notice::Using the latest IG Publisher\n::notice::Not using SUSHI"
}

@test "error: show error and exit with 22" {
  run -22 ./check_inputs.sh "false" "1.2.3"
  assert_output "ERROR: script.sh, line 11: this is not so good"
}
