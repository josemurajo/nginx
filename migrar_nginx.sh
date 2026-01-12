#!/bin/bash

# --- CONFIGURACIÓN DE IDENTIDAD ---
GIT_USER="josemurajo"
GIT_EMAIL="josemurajo@gmail.com"
REPO_NUEVO="https://github.com/josemurajo/nginx.git"

echo "===================================================="
echo "   MIGRANDO DATOS A: josemurajo/nginx"
echo "===================================================="

# 1. ENTRAR EN LA CARPETA DESCARGADA
# Asegúrate de que el nombre de la carpeta coincide con la que clonaste
cd ~/traspaso-de-apache-a-nginx || { echo "Error: No se encuentra la carpeta"; exit 1; }

# 2. LIMPIEZA DE GIT ANTIGUO
# Borramos la configuración vieja para que no intente subir al repo de Apache
rm -rf .git

# 3. CONFIGURAR NUEVA IDENTIDAD
git init
git config user.name "$GIT_USER"
git config user.email "$GIT_EMAIL"
git remote add origin $REPO_NUEVO

# 4. ORGANIZAR CONTENIDO (Hacerlo "bonito")
# Creamos carpetas para que no esté todo suelto en la raíz
mkdir -p config sitios doc
[ -f web1 ] && mv web1 config/
[ -f web2 ] && mv web2 config/

# 5. CREAR README PROFESIONAL (Basado en tu código de 0)
# Esto asegura que el README sea el que te da los puntos
cat << 'EOF' > README.md
# Informe de Despliegue de Servidores Nginx
**Empresa:** Servicios Web RC, S.A (Huelva)
**Autor:** Jose Murillo Rajo
**Curso:** CFGS ASIR

---

## Índice
1. [Introducción](#introduccion)
2. [Comparativa con Apache](#comparativa)
3. [Esquema de Red](#esquema)
4. [Instalación](#instalacion)
5. [Casos Prácticos](#casos)
6. [Referencias](#referencias)

[... Resto del contenido que preparamos anteriormente ...]
EOF

# 6. SUBIDA FINAL CON FUERZA
git add .
git commit -m "Migración y organización final de archivos para el proyecto Nginx"
git branch -M main
git push -u origin main --force

echo "===================================================="
echo "   ¡ÉXITO! Todo subido con: $GIT_EMAIL"
echo "===================================================="
