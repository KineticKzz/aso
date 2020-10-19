#!/bin/bash

if [ $(id -u) -ne 0 ]
then
	echo "No eres el root"
else
	echo "Eres el root"
fi
