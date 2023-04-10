# moodle-docker
Docker image for moodle installation

# Tutorials for installing moodle manually
- [Install Moodle on Debian 11](https://www.linuxtuto.com/how-to-install-moodle-on-debian-11/)
- [Offical Moodle Installation Guide](https://docs.moodle.org/401/en/Installing_Moodle_on_Debian_based_distributions)
- [PHP Settings by CLI](https://www.inmotionhosting.com/support/website/command-line-settings/)

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