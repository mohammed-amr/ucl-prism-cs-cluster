#!/bin/bash

UNIQUEID=$(uuidgen)
UNIQUEID=${UNIQUEID:0:13}

mkdir /scratch0/$USER/
BASEDIR="/scratch0/$USER/"

COPYDIR="${BASEDIR}${UNIQUEID}/"
mkdir $COPYDIR

rsync -ar --info=progress2 /home/$USER/datasets/testData.zip $COPYDIR

cd $COPYDIR

unzip -q testData.zip
rm testData.zip
