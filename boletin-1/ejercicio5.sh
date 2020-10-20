#/bin/bash
# Realiza un script, utilizando el programa dialog y el #comando pkill, de forma que nos muestre en pantalla el 
#nombre de usuarios conectados. A continuación nos pregunte #el nombre de un usuario para desconectarlo (Esta acción #sólo puede ser realizada por el root)

if [ $(id -u) -ne 0 ]
then
	echo "No eres el root"
	exit
else
	continue
fi

dialog --inputbox "Los usuarios que están conectados son: \n$(who|cut -d" " -f1)\n ¿Que usuario desea desconectar?" 0 0 2>fich

usuario=`cat fich`
rm -f fich

pkill -9 -u $usuario
