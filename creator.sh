#---------PEDIR DATOS------------------------
read -p 'DIME EL DOMINIO DE PAGINA' dominio
read -p 'DIME UN NOMBRE PARA EL CONF' conf_file
read -p 'DIME LA PAGINA A CLONAR' url
read -p 'DIME EL PUERTO A UTILIZARSE' puerto


#----------CREAR DIRECTORIO WEB--------------
mkdir /var/www/$dominio
cd /var/www/$dominio

#----------DESCARGAR PAGINA DE EJEMPLO-------------------
wget $url

#----------PONER EN ESCUCHA EL PUERTO----------------
echo 'Listen '$puerto >> /etc/apache2/ports.conf

#----------CREAR EL VIRTUAL HOST----------------
echo -e "<VirtualHost *:80> \n ServerAdmin admin@example.com \n DocumentRoot /var/www/"$dominio " \n ErrorLog ${APACHE_LOG_DIR}/error.log \n CustomLog ${APACHE_LOG_DIR}/access.log combined \n </VirtualHost>" >> '/etc/apache2/sites-available/'$conf_file'.conf'

#----------ACTIVAR EL SITE------------------------------------
a2ensite $conf_file'.conf'

#----------REINICIAR APACHE----------------------------------
systemctl reload apache2

#----------IMPRIMIR ESTADO APACHE-------------------------
echo '----------------ESTADO APACHE-------------------- '
systemctl status apache2
