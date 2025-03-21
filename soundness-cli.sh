#!/bin/bash

# Logo scripti çalıştırılıyor
curl -s https://raw.githubusercontent.com/0xGutso/logo/refs/heads/main/logo.sh | bash
sleep 3

# Docker kontrolü ve kurulumu
if ! command -v docker &> /dev/null; then
    echo "Docker bulunamadı, yükleniyor..."
    curl -fsSL https://get.docker.com | sh
    sudo systemctl start docker
    sudo systemctl enable docker
else 
    echo "Docker zaten yüklü."
fi

# Rust kurulumu
echo "Rust kuruluyor..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
echo 'source $HOME/.cargo/env' >> ~/.bashrc
source ~/.bashrc

# Rust kontrolü
if rustc --version && cargo --version; then
    echo "Rust başarıyla yüklendi: $(rustc --version)"
else
    echo "Hata: Rust yüklenemedi."
    exit 1
fi
sleep 2

# Soundness kurulumu
echo "Soundness kuruluyor..."
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install.sh -o install.sh
if [ ! -s install.sh ]; then
    echo "Hata: install.sh dosyası boş veya eksik. Lütfen URL'yi kontrol edin!"
    exit 1
fi
bash install.sh
source ~/.bashrc

# Soundness kontrolü
if command -v soundnessup &> /dev/null && soundnessup --version; then
    echo "Soundness başarıyla kuruldu: $(soundnessup --version)"
    soundnessup install
    sleep 3
    soundnessup update
else
    echo "Hata: Soundness kurulumu başarısız oldu."
    exit 1
fi

# Key oluşturma
if command -v soundness-cli &> /dev/null; then
    echo "Key oluşturuluyor..."
    sleep 3
    soundness-cli generate-key --name my-key
    if [ $? -eq 0 ]; then
        echo "Key başarıyla oluşturuldu!"
    else
        echo "Hata: Key oluşturulamadı."
        exit 1
    fi
else
    echo "Hata: soundness-cli bulunamadı!"
    exit 1
fi

# Sürüm kontrolleri
echo "Sürümler kontrol ediliyor"
sleep 3
docker --version
rustc --version
soundnessup --version
