# Dockergen

Dockergen is a CLI tool that automates the creation of development environments using Docker. It generates the necessary Dockerfiles, `docker-compose.yml` files, and initializes the project structure using a temporary Docker container.

## Features

- Supports multiple programming languages: **Node.js (Express), Python (Flask), PHP (Symfony)**
- Automatically generates Dockerfiles and `docker-compose.yml`
- Creates the project skeleton using a temporary Docker container
- Simple installation and update commands

## Installation

To install DockerGen globally, run:

```sh
curl -sSL https://raw.githubusercontent.com/MFernandez93/dockergen-cli/main/dockergen.sh -o dockergen.sh
chmod +x dockergen.sh
./dockergen.sh --install
```

## Usage

```sh
dockergen [PROJECT_NAME] [LANGUAGE]
```

- `PROJECT_NAME`: Name of the project (default: `my_project`)
- `LANGUAGE`: Programming language (`node`, `python`, `php`)

### Example

```sh
dockergen myapp node
```

This will:

1. Create a folder `myapp`
2. Download the corresponding Dockerfile and `docker-compose.yml`
3. Use Docker to initialize the project

## Commands

- `dockergen --install` → Installs Dockergen globally
- `dockergen --update` → Updates Dockergen to the latest version
- `dockergen -h` → Shows the help message

## Requirements

- Docker installed and running
- Internet connection to fetch templates

## Contributing

Feel free to submit pull requests or report issues on the [GitHub repository](https://github.com/MFernandez93/dockergen-cli).

## License

This project is licensed under the MIT License.
