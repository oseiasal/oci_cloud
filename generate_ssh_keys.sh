#!/bin/bash

# Diretório para armazenar as chaves
SSH_DIR="ssh_keys"
mkdir -p $SSH_DIR

# Função para gerar par de chaves
generate_key_pair() {
    local name=$1
    local key_path="$SSH_DIR/$name"
    
    echo "Gerando par de chaves para $name..."
    ssh-keygen -t rsa -b 4096 -f "$key_path" -N ""
    
    # Ajustar permissões
    chmod 600 "$key_path"
    chmod 644 "$key_path.pub"
    
    echo "Chaves geradas com sucesso:"
    echo "Chave privada: $key_path"
    echo "Chave pública: $key_path.pub"
}

# Função para listar todas as chaves
list_keys() {
    echo "Chaves disponíveis:"
    ls -l $SSH_DIR/*.pem 2>/dev/null || echo "Nenhuma chave encontrada"
}

# Função para remover chave
remove_key() {
    local name=$1
    local key_path="$SSH_DIR/$name"
    
    if [ -f "$key_path" ]; then
        rm "$key_path" "$key_path.pub"
        echo "Chave $name removida com sucesso"
    else
        echo "Chave $name não encontrada"
    fi
}

# Menu principal
case "$1" in
    "generate")
        if [ -z "$2" ]; then
            echo "Uso: $0 generate <nome_da_chave>"
            exit 1
        fi
        generate_key_pair "$2"
        ;;
    "list")
        list_keys
        ;;
    "remove")
        if [ -z "$2" ]; then
            echo "Uso: $0 remove <nome_da_chave>"
            exit 1
        fi
        remove_key "$2"
        ;;
    *)
        echo "Uso: $0 {generate|list|remove} [nome_da_chave]"
        echo "  generate <nome_da_chave> - Gera um novo par de chaves"
        echo "  list                    - Lista todas as chaves existentes"
        echo "  remove <nome_da_chave>  - Remove um par de chaves"
        exit 1
        ;;
esac