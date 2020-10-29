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
funcionMenu(){
echo "_____________________"
echo ""
echo "MENU INFORMACION RED"
echo "_____________________"
}

funcionComprobacionRoot
	
wget -qO- ifconfig.co/ip
	
	
	
	

