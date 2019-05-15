#!/bin/bash
cd estaciones
sed 1d estacion2.csv > out2.csv | sed 1d estacion3.csv > out3.csv | sed 1d estacion4.csv > out4.csv
cat estacion1.csv out2.csv out3.csv out4.csv > out5.csv
sed 's/,/./g' out5.csv > out6.csv
sed 's/;/,/g' out6.csv > salida1.csv
rm out*
sed "s+/+,+g" salida1.csv > salida2.csv
sed "s+:+,+g" salida2.csv > salida3.csv
sed "s+FECHA,HHMMSS,DIR,VEL+dia,mes,ano,hora,minuto,segundo,dir,vel+1" salida3.csv > consolidado.csv
rm salida*
csvsql --query "select mes,dir,round(avg(vel),1) as prom_vel_mes from prueba group by mes,dir" consolidado.csv > ../velocidad-por-mes.csv
csvsql --query "select ano,dir,round(avg(vel),1) as prom_vel_ano from prueba group by ano,dir" consolidado.csv > ../velocidad-por-ano.csv
csvsql --query "select hora,dir,round(avg(vel),1) as prom_vel_hora from prueba group by hora,dir" consolidado.csv  > ../velocidad-por-hora.csv
rm cons* prueba*
