#!/bin/bash

set -o errexit  # abort on nonzero exit status
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

if [[ $# -ne 3 ]]; then
  echo "::error::Illegal number of parameters"
fi

IG_PUBLISHER_VERSION=$1
SUSHI_VERSION=$2
JAVA_MAX_HEAP_MEMORY=$3

if [ "$IG_PUBLISHER_VERSION" = "latest" ]; then
  echo "::notice::Using the latest IG Publisher"
elif [[ "$IG_PUBLISHER_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "::notice::Using IG Publisher version ${IG_PUBLISHER_VERSION}"
else
  echo "::error::Bad IG Publisher version"
  exit 22 # Invalid argument
fi

if [ "$SUSHI_VERSION" = "false" ]; then
  echo "::notice::Not using SUSHI"
elif [ "$SUSHI_VERSION" = "latest" ]; then
  echo "::notice::Using the latest SUSHI"
elif [[ "$SUSHI_VERSION" =~ ^[0-9]+(\.[0-9]+(\.[0-9]+)?)?$ ]]; then
  echo "::notice::Using SUSHI version ${SUSHI_VERSION}"
else
  echo "::error::Bad IG Publisher version"
  exit 22 # Invalid argument
fi

# https://docs.oracle.com/en/java/javase/25/docs/specs/man/java.html#extra-options-for-java
if [[ "$JAVA_MAX_HEAP_MEMORY" =~ ^[1-9][0-9]*[kKmMgG]$ ]]; then
  echo "::notice::Setting Java max heap memory to ${JAVA_MAX_HEAP_MEMORY}"
else
  echo "::error::Invalid Java max heap memory value"
  exit 22 # Invalid argument
fi

# Commands: https://github.com/actions/toolkit/blob/main/docs/commands.md
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
