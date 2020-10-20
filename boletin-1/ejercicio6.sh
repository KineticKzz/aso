#!/bin/bash
#Realiza un script que nos muestre en pantalla: Nuestra Ip #es: xxx.xxx.xxxx.xxxx

if [ $(id -u) -ne 0 ]
then
	dialog --infobox "No eres el root" 0 0
	exit
else
	continue
fi


dialog --infobox $(hostname -I|cut -d" " -f1)
