#/bin/bash
#Realiza un script a que se le pasa por parámetro un proceso #(por ejemplo ssh) y nos indica si se está ejecutando.


if [ $(id -u) -ne 0 ]
then
	dialog --infobox "No eres el root" 0 0
	exit
else
	continue
fi

ps aux|grep -i $1|grep -v grep|grep -v $0>/dev/null

if [ $? -ne 0 ]
then
	dialog --infobox "El proceso $1 no está en ejecución" 0 0
else
	dialog --infobox "El servicio $1 se está ejecutando" 0 0
fi
