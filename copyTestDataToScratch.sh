#!/bin/bash

UNIQUEID=$(uuidgen)
UNIQUEID=${UNIQUEID:0:13}

mkdir /scratch0/mabdelfa/
BASEDIR="/scratch0/mabdelfa/"

COPYDIR="${BASEDIR}${UNIQUEID}/"
mkdir $COPYDIR

rsync -ar --info=progress2 /home/mabdelfa/datasets/testData.zip $COPYDIR

cd $COPYDIR

unzip -q testData.zip
rm testData.zip
