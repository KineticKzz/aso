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

if [ ! -d /var/practicas ]
then
	mkdir /var/practicas
fi
	
find /home/*/practica-* > aux
for i in $(cat aux)
do
	usuario=$(echo $i|cut -d"/" -f3)
	practica=$(echo $i|cut -d"/" -f4) 
	archivo=/var/practicas/$usuario-$practica
	cp $i $archivo
done
	
