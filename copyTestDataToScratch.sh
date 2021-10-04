#!/bin/bash

UNIQUEID=$(uuidgen)
UNIQUEID=${UNIQUEID:0:13}

mkdir /scratch0/YOUCLUSTERUSERNAME/
BASEDIR="/scratch0/YOUCLUSTERUSERNAME/"

COPYDIR="${BASEDIR}${UNIQUEID}/"
mkdir $COPYDIR

rsync -ar --info=progress2 /home/YOUCLUSTERUSERNAME/datasets/testData.zip $COPYDIR

cd $COPYDIR

unzip -q testData.zip
rm testData.zip
