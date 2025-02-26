 <!-- oci session authenticate  --region sa-saopaulo-1  -->
Validar se o config file está correto
`oci os ns get`


Gerar pares de chaves
```


openssl genrsa -out oci_api_key.pem 2048
openssl rsa -pubout -in oci_api_key.pem -out oci_api_key_public.pem
```


Chaves SSH
ssh-keygen -t rsa -b 4096 -f ~/.oci/id_rsa


.
├── ansible/
│   ├── playbook.yml
│   ├── roles/
│   │   ├── docker/
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   ├── iptables/
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   ├── n8n/
│   │   │   └── tasks/
│   │   │       └── main.yml
│   │   └── openvpn_server/
│   │       └── tasks/
│   │           └── main.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── vcn.tf
│   ├── open_vpn_sec_list.tf
│   ├── inventory.tpl
│   ├── modules/
│   │   ├── instance/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── network/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
├── .gitignore
├── .vscode/
│   └── settings.json
└── README.md