## Soundness Bekleme Sırasına Katılma

* Kurulumu doğrudan aşağıdaki kodlar ile yapabilirsiniz.
* Kodları kopyalayıp yapıştırdıktan sonra aşamaları özenle takip edin.
* Size verilen 12 haneli mnemonic kelimelerini kaydedin.
* Verilen Public Key'i Soundness Discord'una gidip ``testnet-access`` kanalında paylaşın.
* Tüm işlemler bu kadar.

## Adımlar

* Docker ve Rust kurulumunu yapın

```
curl -s https://raw.githubusercontent.com/0xGutso/soundness-layer/refs/heads/main/soundness-cli.sh | bash
```

* Soundness CLI kurulumunu yapın

```
curl -sSL https://raw.githubusercontent.com/soundnesslabs/soundness-layer/main/soundnessup/install | bash
```

```
source ~/.bashrc
```

```
soundnessup install  
soundnessup update   
```
* Key oluşturun ve kaydedin, ardından şifre oluşturun

```
soundness-cli generate-key --name my-key
```

### Diğer kodlar

* Mnemonic kelimelerini içeriye aktarır

```
soundness-cli import-key --name my-key
```

* Public keyinizi görüntüler
```
soundness-cli list-keys
```