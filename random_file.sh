#!/bin/bash

# Define the base directory where everything will be created
BASE_DIR="random_files"

NUM_DIRS=5
NUM_FILES=10

MIN_SIZE=100
MAX_SIZE=1000


mkdir -p "$BASE_DIR"


random_size() {
  echo $((RANDOM % (MAX_SIZE - MIN_SIZE + 1) + MIN_SIZE))
}


random_content() {
  head -c "$1" /dev/random
}


for ((i = 1; i <= NUM_DIRS; i++)); do
  DIR_NAME="$BASE_DIR/dir_$i"
  mkdir -p "$DIR_NAME"

  for ((j = 1; j <= NUM_FILES; j++)); do
    FILE_NAME="$DIR_NAME/file_$j.txt"
    SIZE=$(random_size)

    echo "Creating file: $FILE_NAME with size $SIZE bytes"
    random_content "$SIZE" > "$FILE_NAME"
  done

done

for ((k = 1; k <= NUM_FILES; k++)); do
  FILE_NAME="$BASE_DIR/random_file_$k.txt"
  SIZE=$(random_size)

  echo "Creating file: $FILE_NAME with size $SIZE bytes"
  random_content "$SIZE" > "$FILE_NAME"
done

echo "All random files and directories have been created in $BASE_DIR"
