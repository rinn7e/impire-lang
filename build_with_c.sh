#!/bin/bash

IMPIRE_FILE="static/operator-semicolon.im"
IMPIRE_FILE2="static/operator-primitive.im"
IMAGE="static/generate-image.im"

cd app
gcc -c -fPIC cbits.c -o cbits.o 
gcc cbits.o -shared -o cbits.so 

cd ..
stack build --ghc-options="-O0"
# stack exec impire $IMAGE
stack exec impire "static/mutable-variable.im"