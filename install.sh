#!/bin/bash

read -p "Customer Key: " customer_key

read -p "Region (US/EU/AE): " region
case $region in
    us|US) region="US";;
    eu|EU) region="EU";;
    ae|AE|uae|UAE) region="AE";;
    *) echo -e "\n ** Invalid region, please choose US, EU or AE ** "; exit;;
esac

echo ""
echo "* Please enter proxy details (enter for none)"

read -p "Proxy Server (NO PORT): " proxy_server

if [ -n "$proxy_server" ]; then
    read -p "Proxy Port: " proxy_port

    echo ""
    echo "* Please enter proxy auth (enter for none)"

    read -p "Proxy User: " proxy_user

    if [ -n "$proxy_user" ]; then
        read -s -p "Proxy Password: " proxy_pass
        export proxy_pass
    fi
fi

echo ""
echo "* Please enter SSH details"
read -p "SSH user: " ANSIBLE_USER
read -s -p "SSH password: " ANSIBLE_PASSWORD

if [ -n "$proxy_server" ]; then
    if [ -z "$proxy_user" ]; then
        https_proxy="$proxy_server:$proxy_port"
    else
        https_proxy="$proxy_user:$proxy_pass@$proxy_server:$proxy_port"
    fi
    export https_proxy
fi

export ANSIBLE_PASSWORD
ansible-playbook \
    -i inventory.ini \
    -e "region=${region}" \
    -e "customer_key=${customer_key}" \
    -e "proxy_server=${proxy_server}" \
    -e "proxy_port=${proxy_port}" \
    -e "proxy_user=${proxy_user}" \
    -e proxy_pass='{{ lookup("env","proxy_pass") }}' \
    -e "ansible_user=$ANSIBLE_USER" \
    -e ansible_password='{{ lookup("env","ANSIBLE_PASSWORD") }}' \
    -e ansible_sudo_pass='{{ lookup("env","ANSIBLE_PASSWORD") }}' \
    -e https_proxy='{{ lookup("env","https_proxy") }}' \
    install_agent.yml


