#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	clear "No eres el root"
	sleep 2;clear;exit 1
else
	continue
fi;}
funcionComprobacionParametros(){
if [ $1 -eq 2 ] ; then
	continue
else
	echo "El número de parámetros es incorrecto, tienen que ser x parámetros"
	sleep 2;clear;exit 1
fi;}

funcionComprobacionRoot
funcionComprobacionParametros $#


	
	
	
	
	
	
	
	
	
	
	
	
