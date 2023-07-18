#!/bin/bash

read -p "Customer Key: " customer_key

read -p "Region (US or EU): " region

read -p "PROXY_SERVER: " proxy_server

read -p "PROXY_PORT: " proxy_port

read -p "PROXY_UNAME: " proxy_user

read -s -p "PROXY_PSWD: " proxy_pass

case $region in
    us|US) region="US";;
    eu|EU) region="EU";;
    *) echo "\n ** Invalid region, please choose US or EU ** "; exit;;
esac

read -s -p "SSH password: " password

ansible-playbook \
    -i inventory.ini \
    -e "region=${region}" \
    -e "customer_key=${customer_key}" \
    -e "proxy_server=${proxy_server}" \
    -e "proxy_port=${proxy_port}" \
    -e "proxy_user=${proxy_user}" \
    -e "proxy_pass=${proxy_pass}" \
    -e "ansible_password=${password}" \
    -e "ansible_sudo_pass=${password}" \
    install_agent.yml


