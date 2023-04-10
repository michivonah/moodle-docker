# moodle-docker
Docker image for moodle installation

## Features
- All in one Docker image
- Easily deployment

## System requirements
- Linux system (recommended)
- Docker Engine & Docker Compose installed

# Get started
1. First install docker
    ```bash
    sudo apt-get install docker.io docker-compose -y
    ```
1. Than start a new container with theese comand:
    ```bash
    sudo docker run -it -p 8080:80 michivonah/moodle-docker
    ```
1. Now you can go to ```http://localhost:8080``` in your browser and check if its running

# Build the image yourself
You need the [docker engine](https://docs.docker.com/engine/install/) installed on your local machine.
1. Clone this git repository to your local machine
    ```bash
    git clone https://github.com/michivonah/moodle-docker.git
    ```
1. Navigate into the directory of the repo
     ```bash
    cd moodle-docker
    ```
1. Build the image
     ```bash
    docker build -t moodle-docker:latest .
    ```
1. Now you can start a container with your image
    ```bash
    sudo docker run -it -p 8080:80 moodle-docker
    ```
# Tutorials for installing moodle manually
- [Install Moodle on Debian 11](https://www.linuxtuto.com/how-to-install-moodle-on-debian-11/)
- [Offical Moodle Installation Guide](https://docs.moodle.org/401/en/Installing_Moodle_on_Debian_based_distributions)
- [PHP Settings by CLI](https://www.inmotionhosting.com/support/website/command-line-settings/)