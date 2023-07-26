# Cloudamize Ansible Playbook

This is an Ansible playbook to automate the installation of the cloudamize collector on linux servers.

**Please note that this playbook is an example of a single method of installing the agent on many machines and may require modifications to work in your environment.**

## Step 1
Install ansible on a machine that has ssh access to your linux servers.

* On Ubuntu/debian run `sudo apt install ansible`
* On Centos/red hat run `sudo yum install ansible`

## Step 2
Clone this repo
`git clone https://github.com/cloudreach/cmz-ansible.git` or download the [zip file](https://github.com/cloudreach/cmz-ansible/archive/refs/heads/main.zip).

## Step 3
Edit `inventory.ini` to include the linux servers you wish to monitor.


```
[cloudamize]
###############################################################################
###################### Add Host names or IP addresses here ####################

example1.server.com
example2.server.com
example3.server.com


###############################################################################
[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```



## Step 4
Run the install shell script and follow the prompts.  
Note: A proxy server is not required and these values can be left blank.

```
$ ./install.sh
Customer Key: 0dbc6803...
Region (US/EU/AE): us

* Please enter proxy details (enter for none)
Proxy Server (NO PORT): 10.0.0.1
Proxy Port: 80

* Please enter proxy auth (enter for none)
Proxy User: someuser
Proxy Password:
* Please enter SSH details
SSH user: ansible
SSH password:
```

## Step 5

Visit [https://console.cloudamize.com](https://console.cloudamize.com) and confirm that the agents have been installed.
