#!/bin/bash
AMOUNT=30;
WIDTH=500;
HEIGHT=300;

for n in $(seq -w $AMOUNT); do wget http://lorempixel.com/$WIDTH/$HEIGHT/ -O $n.jpg; done;

# to download within a range, e.g. 31 to 50, use:
# for n in $(seq -w 31 50); do wget http://lorempixel.com/$WIDTH/$HEIGHT/ -O $n.jpg; done
