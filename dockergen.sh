#!/bin/bash

set -e

# URL base donde están almacenados los templates
BASE_URL="https://raw.githubusercontent.com/tuusuario/tu-repo/main/templates"

PROJECT_NAME=${1:-my_project}
LANGUAGE=${2:-node}

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Descargar el template adecuado
case "$LANGUAGE" in
  node)
    curl -sSL "$BASE_URL/Dockerfile.node" -o Dockerfile
    ;;
  python)
    curl -sSL "$BASE_URL/Dockerfile.python" -o Dockerfile
    ;;
  php)
    curl -sSL "$BASE_URL/Dockerfile.php" -o Dockerfile
    ;;
  *)
    echo "Lenguaje no soportado"
    exit 1
    ;;
esac

echo "Proyecto $PROJECT_NAME creado con Docker para $LANGUAGE"