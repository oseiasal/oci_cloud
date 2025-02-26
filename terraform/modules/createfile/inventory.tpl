[webserver]
webserver ansible_host=${webserver_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws_terraform 

[n8nmachine]
n8n ansible_host=${n8nmachine_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws_terraform
