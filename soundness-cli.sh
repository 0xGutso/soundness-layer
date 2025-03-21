#!/bin/bash

curl -s https://raw.githubusercontent.com/0xGutso/logo/refs/heads/main/logo.sh | bash
sleep 3

# Docker kontrolü ve kurulumu
if ! command -v docker &> /dev/null 
then 
    echo "Docker bulunamadı, Docker yükleniyor..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else 
    echo "Docker zaten cihazda kurulu, sonraki aşamaya geçiliyor."
fi

# Rust kurulumu
echo "Rust kuruluyor..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
echo 'source $HOME/.cargo' >>bashrc

# Rust kontrolü
if rustc --version && cargo --version; then
    echo "Rust kurulumu tamamlandı: $(rustc --version)"
else
    echo "Hata: Rust kurulumu tamamlanamadı."
    exit 1
fi
sleep 2
echo "Lütfen sonraki aşamaya geçiniz."

