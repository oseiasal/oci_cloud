# Gerenciador de Chaves SSH

Este script permite gerenciar pares de chaves SSH de forma organizada e segura.

## Estrutura de Diretórios

```
ansible/
└── scripts/
    ├── generate_ssh_keys.sh
    └── ssh_keys/           # Diretório onde as chaves são armazenadas
```

## Como Usar

1. Primeiro, torne o script executável:
```bash
chmod +x generate_ssh_keys.sh
```

2. Comandos disponíveis:

### Gerar novo par de chaves
```bash
./generate_ssh_keys.sh generate nome_da_chave
```

### Listar todas as chaves
```bash
./generate_ssh_keys.sh list
```

### Remover um par de chaves
```bash
./generate_ssh_keys.sh remove nome_da_chave
```

## Segurança

- As chaves são armazenadas no diretório `ssh_keys/`
- Permissões são automaticamente ajustadas:
  - Chaves privadas: 600 (rw-------)
  - Chaves públicas: 644 (rw-r--r--)

## Integração com Ansible

Para usar as chaves geradas com o Ansible, você pode:

1. Copiar a chave pública para o servidor alvo:
```bash
ssh-copy-id -i ssh_keys/nome_da_chave.pub usuario@servidor
```

2. Configurar o Ansible para usar a chave privada no arquivo `inventory.ini`:
```ini
[servidores]
servidor ansible_ssh_private_key_file=ssh_keys/nome_da_chave
``` 