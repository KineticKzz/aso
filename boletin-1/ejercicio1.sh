#!bin/bash

who| grep -i root > /dev/null

if [ $? -eq 0 ] 
then
	echo "El usuario root está conectado"
else
	echo "El usuario root no está conectado"
fi
