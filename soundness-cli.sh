#!/bin/bash

curl -s https://raw.githubusercontent.com/0xGutso/logo/refs/heads/main/logo.sh | bash
sleep 3

echo "Kurulum başlatılıyor"
sleep 1

if ! command -v docker &> /dev/null 
    then 
        echo "Docker bulunamadı, Docker yükleniyor..."
        sudo apt update && sudo apt upgrade -y
    else 
    echo "Docker zaten cihazda kurulu, sonraki aşamaya geçiliyor."
fi

echo "Rust kuruluyor"
sleep 2

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustc --version
cargo --version
echo 'source $HOME/.cargo/env' >> ~/.bashrc

echo "Rust kurulumu tamamlandı, sonraki aşamaya geçiliyor."
sleep 3

echo "Soundness kurulumu yapılıyor..."
sleep 2
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
source ~/.bashrc
soundnessup install
soundnessup update


echo "Kurulum yapıldı, lütfen bir sonraki aşamada verilecek olan mnemonic kelimelerini kaydedin! Ardından şifrenizi iki defa girin."
sleep 6

soundness-cli generate-key --name my-key

echo "Yukarıda verilen public key için lütfen Readme.MD dosyasına göz atmayı unutmayın."
sleep 2

echo "Tüm işlemler bu kadardı, bol şans."


