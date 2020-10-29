#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script
clear

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	clear "No eres el root"
	sleep 2;clear;exit 1
else
	continue
fi;}
funcionMenu(){
echo "____________________"
echo "MENÚ SSH"
echo "____________________"
echo "1.- Permitir o denegar acceso por SSH al usuario root"
echo "2.- Crear documento que registre los intentos fallidos"
echo "3.- Denegar el acceso SSH a los usuarios del sistema"
echo "4.- Conexión remota por SSH"
echo "5.- Salir"
}

funcionAccionesMenu(){
case $opcion in

1)
    clear 
    read -p "¿Deseas permitir que el usuario ROOT se conecte por SSH? Por defecto está deshabilitado. s / n " opcion_root

    case $opcion_root in
        s|S) 
        sed  -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 
        sed  -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
        sleep 1 
        echo "A root se le permitirá la conexión vía SSH"
        sleep 3;;
        n|N) 
        sed  -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
        sed  -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
        sleep 1
        echo "Prohibido acceder como root"
        sleep 3;;
        *) 
        echo "Has introducida una opción no válida"
        sleep 3;;
    esac; systemctl restart sshd ;; 
    

2) 
    clear
    echo "Se creará un fichero registrando los últimos intentos fallidos de acceso al sistema"
    sleep 1

    mkdir /root/ssh_fallidos 2> /dev/null

    fecha=$(date +%y%m%d)
    cat /var/log/auth.log | grep -w sshd | tail -n 50 >> /root/ssh_fallidos/$fecha.log

    if [ $? -eq 0 ]
    then 
        echo "Registro creado"
        sleep 5
    else
        echo "Registro fallido"
        sleep 3
    fi;; 
    
    
3)
    clear
    echo "Estos son los usuarios que hay creados en el sistema"
    sleep 2

    usuarios=`grep -w [1-9][0-9][0-9][0-9] /etc/passwd`

    for nombre_usuario in $usuarios
    do
        nombre=`echo $nombre_usuario | cut -f 1 -d ":"`
        echo $nombre
    done

    echo ""
    read -p "Introduce los nombres que quieras de los mostrados, para prohibir el acceso vía SSH --> " users
    sleep 2

    while [ -z "$users" ]
    do
        read -p "Tienes que introducir correctamente los usuarios --> " users
    done

    echo "DenyUsers $users" >> /etc/ssh/sshd_config

    if [ $? -ne 0 ]
        then
            echo "Ha habido un error, vuelvelo a intentar"
            sleep 4
        else
            echo "Se han introducido correctamente los usuarios a los que se va a denegar el acceso vía SSH al equipo"
            sleep 3
    fi;; 
    
4)
    read -p "Introduce el usuario, la direccion, y el puerto (por defecto es 22) -> " user direccion puerto

    while [ -z "$user" -o -z "$direccion" ]
    do
        clear
        echo "No has introducido correctamente todos los datos"
        read -p "Vuelve a introducir el usuario, la direccion, y el puerto (por defecto es 22) -> "  user direccion puerto
    done

    if [ -z $puerto ]
    then
        puerto=22
    fi

    ssh $user@$direccion -p $puerto 2> /dev/null

    if [ $? -ne 0 ]
    then
        echo "Ha habido un problema con la conexión. Revisa si los datos están introducidos correctamente"
        sleep 3
    else
        echo "La conexión ha finalizado correctamente"
        sleep 3
    fi;;
esac
}

funcionComprobacionRoot

opcion=0
while [ $opcion -lt 5 ]
do
funcionMenu
read -p "Elija una opción: " opcion
funcionAccionesMenu
done


	
	
	
	
	
	
	
	
	
	
