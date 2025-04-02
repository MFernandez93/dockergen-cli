#!/bin/bash

set -e

# URL base donde están almacenados los templates
BASE_URL="https://raw.githubusercontent.com/MFernandez93/dockergen-templates/main"
SCRIPT_URL="https://raw.githubusercontent.com/MFernandez93/dockergen-cli/main/dockergen.sh"
INSTALL_PATH="/usr/local/bin/dockergen"

show_help() {
    echo "Usage: dockergen [PROJECT_NAME] [LANGUAGE]"
    echo ""
    echo "Commands:"
    echo "  --install    Install dockergen in /usr/local/bin/"
    echo "  --update     Update dockergen from the remote repository"
    echo "  -h, --help   Show this help message"
    echo ""
    echo "Arguments:"
    echo "  PROJECT_NAME  Name of the project (default: my_project)"
    echo "  LANGUAGE      Programming language (options: node, python, php)"
    exit 0
}

install_cli() {
    echo "Installing DockerGen in $INSTALL_PATH..."
    sudo cp "$0" "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    echo "Installation complete. Run 'dockergen -h' for help."
    exit 0
}

update_cli() {
    echo "Updating DockerGen from remote repository..."
    sudo curl -sSL "$SCRIPT_URL" -o "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    echo "Update completed. Run 'dockergen -h' for help."
    exit 0
}

# Manejo de opciones
case "$1" in
  --install)
    install_cli
    ;;
  --update)
    update_cli
    ;;
  -h | --help)
    show_help
    ;;
esac

PROJECT_NAME=${1:-my_project}
LANGUAGE=${2:-node}

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Descargar los templates adecuados
case "$LANGUAGE" in
  node | python | php)
    curl -sSL "$BASE_URL/templates/$LANGUAGE/Dockerfile" -o Dockerfile
    curl -sSL "$BASE_URL/templates/$LANGUAGE/docker-compose.yml" -o docker-compose.yml
    ;;
  *)
    echo "ERROR: Unsupported language. Available options: node, python, php."
    exit 1
    ;;
esac

# Generar el esqueleto del proyecto usando Docker
echo "Generating project skeleton for $LANGUAGE..."
case "$LANGUAGE" in
  node)
    docker run --rm -v "$(pwd):/app" node:lts bash -c "cd /app && npm init -y && npm install express"
    ;;
  python)
    docker run --rm -v "$(pwd):/app" python:latest bash -c "cd /app && python -m venv venv && source venv/bin/activate && pip install flask && touch app.py"
    ;;
  php)
    docker run --rm -v "$(pwd):/app" composer:latest create-project symfony/skeleton /app
    ;;
esac

echo "Project $PROJECT_NAME successfully created with $LANGUAGE."