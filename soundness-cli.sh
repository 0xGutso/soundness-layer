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

# Rust kontrolü ve kurulumu
echo "Rust kuruluyor..."
sleep 2
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustc --version
cargo --version
echo 'source $HOME/.cargo/env' >> ~/.bashrc
echo "Rust kurulumu tamamlandı, sonraki aşamaya geçiliyor."
sleep 3

# Soundness kurulumu
echo "Soundness kurulumu yapılıyor..."
sleep 2
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
source ~/.bashrc
soundnessup install
sleep 2
soundnessup update

# Key oluşturma
echo "Kurulum yapıldı, lütfen bir sonraki aşamada verilecek olan mnemonic kelimelerini kaydedin! Ardından şifrenizi iki defa girin."
sleep 6

echo "Key oluşturuluyor.."
sleep 3
soundness-cli generate-key --name my-key

sleep 3
chmod +x install_soundness.sh
./install_soundness.sh

