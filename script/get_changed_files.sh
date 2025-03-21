#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <commit1> <commit2>"
  exit 1
fi

DIFF_OUTPUT=$(git diff --name-only "$1" "$2"|grep Dockerfile)

PARENT_DIRS=()
FILE_PATHS=()
for FILE_PATH in $DIFF_OUTPUT; do
  if [[ ! -f "$FILE_PATH" ]]; then
    echo "File $FILE_PATH does not exist, skipping."
    continue
  fi
  PARENT_DIR=$(basename "$(dirname "$FILE_PATH")")
  PARENT_DIRS+=("$PARENT_DIR")
  FILE_PATHS+=("$FILE_PATH")
done

PARENT_DIRS_STRING=$(IFS=,; echo "${PARENT_DIRS[*]}")
DIFF_OUTPUT_STRING=$(IFS=,; echo "${FILE_PATHS[*]}")
echo "PARENT_DIRS=$PARENT_DIRS_STRING"
echo "DIFF_OUTPUT=$DIFF_OUTPUT_STRING"

echo "PARENT_DIRS=$PARENT_DIRS_STRING" >> $GITHUB_ENV
echo "DIFF_OUTPUT=$DIFF_OUTPUT_STRING" >> $GITHUB_ENV