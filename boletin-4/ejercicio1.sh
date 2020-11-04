#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 04/11/2020
#Descripción: Ejercicio1, entrega de trabajos

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	clear "No eres el root"
	sleep 2;clear;exit 1
else
	continue
fi;}

funcionComprobacionRoot

find /home/*/practica-* > aux
for i in aux
do
	usuario=$(cut -d"/" -f2)
	echo $usuario
done
	
	
	
	
	
	
	
	
	
	
	
	
