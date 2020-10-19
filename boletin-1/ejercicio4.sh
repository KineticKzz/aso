#!/bin/bash

usuario=$1
cut -d: -f1 /etc/passwd|grep -i $usuario > /dev/null

if [ $? -eq 0 ]
then
	echo "El usuario $usuario existe"
else
	echo "El usuario $usuario no existe en el sistema"
fi
