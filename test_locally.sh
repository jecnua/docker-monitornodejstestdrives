#!/bin/bash

while IFS= read -r -d '' file
do
  shellcheck "$file"
done <   <(find . -iname '*.sh' -not -path '*/\.*' -type f -print0)
