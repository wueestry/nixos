#!/usr/bin/env bash

cd ~/.setup
files=$(find -type f -name "*.nix")
for f in $files
do
    nixfmt $f
done