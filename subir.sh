#!/bin/bash

# --- CONFIGURACIÓN DE IDENTIDAD ---
GIT_USER="josemurajo"
GIT_EMAIL="josemurajo@gmail.com"
REPO_URL="https://github.com/josemurajo/nginx.git"

# --- RUTAS DEL SISTEMA ---
NGINX_SITES="/etc/nginx/sites-available"
PASS_FILE="/etc/nginx/.htpasswd"

echo "===================================================="
echo "   REPOSITORIO: josemurajo/nginx - SERVICIOS WEB RC"
echo "===================================================="

# 1. CONFIGURACIÓN DE IDENTIDAD GIT
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

# 2. CREACIÓN DE ESTRUCTURA ORGANIZADA (Para que quede "bonito")
mkdir -p config sitios/web1/privado sitios/web2 doc

# 3. CASO D: PÁGINA POR DEFECTO PERSONALIZADA
echo "<h1>Bienvenidos a Mi servidor web</h1><p>Tu Nombre: Jose Murillo Rajo</p>" > /var/www/html/index.nginx-debian.html
cp /var/www/html/index.nginx-debian.html ./sitios/default_index.html

# 4. CASO G/H: USUARIO Y CONTRASEÑAS
if [ ! -f $PASS_FILE ]; then
    echo "Configurando acceso privado (htpasswd)..."
    apt update && apt install apache2-utils -y &>/dev/null
    # Crea el usuario 'jose' con la contraseña que elijas
    htpasswd -c $PASS_FILE jose
fi
# Copiamos una referencia (sin la clave real por seguridad, o el archivo si prefieres)
cp $PASS_FILE ./config/.htpasswd_backup

# 5. CASO I: CERTIFICADOS SSL
if [ ! -f /etc/ssl/certs/web1.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/web1.key -out /etc/ssl/certs/web1.crt \
    -subj "/C=ES/ST=Huelva/L=Huelva/O=Servicios Web RC/CN=www.web1.org" &>/dev/null
fi
cp /etc/ssl/certs/web1.crt ./config/web1.crt

# 6. COPIAR CONFIGURACIONES DE NGINX (Punto 3 de Documentación)
echo "Sincronizando archivos de configuración..."
[ -f $NGINX_SITES/web1 ] && cp $NGINX_SITES/web1 ./config/
[ -f $NGINX_SITES/web2 ] && cp $NGINX_SITES/web2 ./config/

# 7. COPIAR CONTENIDO DE LAS WEBS
echo "Bienvenida a la página web1" > sitios/web1/index.html
echo "Bienvenida a la página web2" > sitios/web2/index.html
echo "Zona Privada de Jose Murillo" > sitios/web1/privado/index.html

# 8. SUBIDA A GITHUB
echo "Subiendo todo a josemurajo/nginx..."
git add .
git commit -m "Entrega Final: Todos los casos prácticos (a-i) y documentación"
git push origin main --force

echo "===================================================="
echo "   ¡PROCESO COMPLETADO! Revisa github.com/josemurajo/nginx"
echo "===================================================="
