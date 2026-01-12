# Proyecto de Migración: Servidor Web Apache a Nginx

Este repositorio contiene la documentación técnica y los archivos de configuración necesarios para la migración de un servidor web tradicional basado en Apache hacia una arquitectura de alto rendimiento utilizando Nginx y PHP-FPM.

Proyecto realizado para el ciclo de Administración de Sistemas Informáticos en Red (ASIR).

## Estructura del Repositorio

El proyecto está organizado en 4 módulos principales:

### [1_Configuracion_Nginx](./1_Configuracion_Nginx)
Contiene los archivos de configuración del servidor:
- nginx.conf: Configuración global optimizada.
- sites-available/default: Configuración del bloque de servidor (Virtual Host).
- Ajustes de PHP-FPM para el procesamiento dinámico.

### [2_Paginas_Web](./2_Paginas_Web)
Archivos fuente del sitio web migrado:
- index.php / index.html: Página de prueba y bienvenida.
- Estructura de directorios web (/var/www/html).

### [3_Certificados_y_Claves](./3_Certificados_y_Claves)
Configuración de seguridad SSL/TLS:
- Certificados autofirmados generados con openssl para habilitar HTTPS.
- Claves privadas y públicas para el cifrado del tráfico.
Nota: Estos certificados son para entorno de desarrollo/prácticas.

### [4_Seguridad_Accesos](./4_Seguridad_Accesos)
Implementación de medidas de seguridad adicionales:
- Autenticación básica HTTP (sustitución de .htaccess).
- Reglas de control de acceso por IP.
- Cabeceras de seguridad.

---

## Despliegue e Instalación

### 1. Requisitos Previos
- Sistema Operativo: Ubuntu Server 20.04/22.04 o Debian 11/12.
- Permisos de root.

### 2. Instalación de Nginx y PHP
sudo apt update
sudo apt install nginx php-fpm php-mysql openssl

### 3. Aplicar Configuraciones
Copiar los archivos de la carpeta 1_Configuracion_Nginx a /etc/nginx/:

# Ejemplo de copia de configuración
cp 1_Configuracion_Nginx/default /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

### 4. Reiniciar Servicios
nginx -t   # Comprobar sintaxis
systemctl restart nginx
systemctl restart php8.1-fpm

---

## Autor
Jose Murillo ajo
- Proyecto: Traspaso de Apache a Nginx
- ASIR
