#!/bin/bash
if [ $# -eq 1 ]
then 
	continue
else
	echo "Introduce un parámetro"
	sleep 3
	exit 1
fi

usuario=$1


prueba=$(who|grep -i $usuario|wc -l) > /dev/null

who|grep -i $usuario > /dev/null

if [ $? -eq 0 ]
then
	echo "El usuario $usuario está conectado $prueba vez/veces"
else
	echo "El usuario $usuario no está conectado"
fi

