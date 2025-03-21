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

# Soundness kurulumu
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install.sh | bash
source ~/.bashrc

# Soundness kontrolü
echo "Soundness yüklemesi onaylanıyor..."
if soundnessup --version; then
    echo "Soundness kurulumu tamamlandı: $(soundnessup --version)"
    soundnessup install
    sleep 3
    soundnessup update
else
    echo "Hata: Soundness kurulumu tamamlanamadı."
    exit 1
fi


# Key oluşturma
echo "Kurulum yapıldı, key oluşturuluyor"
sleep 5

echo "Key oluşturuluyor..."
sleep 3
soundness-cli generate-key --name my-key
if [ $? -eq 0 ]; then
    echo "Key başarıyla oluşturuldu!"
else
    echo "Hata: Key oluşturulamadı."
    exit 1
fi

# Sürüm kontrolleri
echo "Sürümler kontrol ediliyor"
sleep 3
docker --version
rustc --version
soundnessup --version
