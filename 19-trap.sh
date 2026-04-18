#!/bin/bash

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR


echo "hello"
echo "world"
echoo "ok"
echo "proceed"