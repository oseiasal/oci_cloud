 <!-- oci session authenticate  --region sa-saopaulo-1  -->
Validar se o config file está correto
`oci os ns get`


Gerar pares de chaves
```


openssl genrsa -out oci_api_key.pem 2048
openssl rsa -pubout -in oci_api_key.pem -out oci_api_key_public.pem
```


Chaves SSH
ssh-keygen -t rsa -b 4096 -f ~/.oci/ssh_auth_key
