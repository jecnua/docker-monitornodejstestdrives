#!/bin/bash

for file in $(find . -iname '*.sh' -not -path '*/\.*' -type f); do shellcheck $file; done;
