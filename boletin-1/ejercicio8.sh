#/bin/bash
#Realiza un script a que se le pasa dos parámetros. El primero representa el archivo origen y el destino el archivo destino. La tarea consiste en copiar el archivo origen en el archivo destino, de forma que si existe indique si se quiere sobrescribir. Se tendrá que comprobar que se ha introducido dos parámetros.

if [ $(id -u) -ne 0 ]
then
	dialog --infobox "No eres el root" 0 0
	sleep 2
	clear
	exit
else
	continue
fi

clear

if [ $# -eq 2 ]
then
	continue
else
	dialog --infobox "No has introducido los dos archivos" 0 0
	sleep 2
	clear
	exit
fi

if [ -f $1 ]
then
	if [ -f $2 ]
	then
		dialog --yesno "El fichero ya existe, ¿desea sobrescribirlo?" 0 0
		if [ $? -eq 0 ]
		then
			cp $1 $2
			dialog --infobox "Archivo sobreescrito con exito" 0 0
			sleep 3
			clear
		else
			dialog --infobox "No se ha copiado el archivo" 0 0
			sleep 3
			clear
		fi
	else
		cp $1 $2
		dialog --infobox "Archivo copiado con exito" 0 0
	fi
else
	dialog --infobox "El fichero $ruta1 no existe." 0 0
fi






