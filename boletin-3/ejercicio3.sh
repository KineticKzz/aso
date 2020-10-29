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
dialog --nocancel --menu "Menu RED" 40 20 5 /
1 "Dirección ip interna" /
2 "Dirección ip pública" /
3 "MAC" /
4 "DNS server" /
5 "Puerta de enlace (gateway)" /
6 "Nombre del equipo" /
7 "Salir" 2>fich1
opcion=$(cat fich1);sleep 1
rm -r fich1
}
#funcionAccionesMenu(){
#case $1 in
#1)

#;;
#2
#}

funcionComprobacionRoot

dialog --nocancel --inputbox "Hemos encontrado en su equipo las siguientes interfaces, diga de cual quiere la informacion: $(ip a|grep "^[2-9]"|cut -d: -f2)" 0 0 2>fich2
	
#wget -qO- ifconfig.co/ip
	
	
	
	

