#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 04/11/2020
#Descripción: Ejercicio sobre phpmyadmin, mysql

dbname="alumnos"
ruta="/home/pc207"
fecha=$(date +%Y-%m-%d)
respaldo=$dbname-$fecha.sql
mysqldump --opt --user=root password=peque $dbname > $ruta/$respaldo
gzip $ruta/$respaldo
find $ruta/*.sql.gz -mtime +30 -exec rm{} \;
