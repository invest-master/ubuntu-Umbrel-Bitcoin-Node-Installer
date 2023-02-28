# Installer Umbrel sur Ubuntu

Ce script va installer Umbrel et Bitcoin Core sur un serveur Ubuntu propre.

## Prérequis

- Un serveur Ubuntu propre
- Accès administrateur

## Installation

1. Téléchargez le script d'installation :

wget https://raw.githubusercontent.com/invest-master/ubuntu-Umbrel-Bitcoin-Node-Installer/main/ubuntu-Umbrel-Bitcoin-Node-Installer.sh

2. Vérifiez l'intégrité du script :

wget https://raw.githubusercontent.com/invest-master/ubuntu-Umbrel-Bitcoin-Node-Installer/main/ubuntu-Umbrel-Bitcoin-Node-Installer.sh.asc
gpg --keyserver keyserver.ubuntu.com --recv-keys 7E3BA6A42621CE17F8104E161F38C96AEBA390DD
gpg --verify ubuntu-Umbrel-Bitcoin-Node-Installer.sh.asc ubuntu-Umbrel-Bitcoin-Node-Installer.sh

3. Installez Umbrel et Bitcoin Core :

chmod +x ubuntu-Umbrel-Bitcoin-Node-Installer.sh
./ubuntu-Umbrel-Bitcoin-Node-Installer.sh

shell
Copy code

4. Suivez les instructions à l'écran pour configurer votre nœud Umbrel.

## Variables d'environnement

Notez que vous devrez fournir les variables nécessaires telles que RPC_USER, RPC_PASSWORD, WALLET_NAME, NETWORK, CHAIN, BITCOIN_DATA_DIR, LND_DATA_DIR, NODE_PUBKEY, NODE_ADDRESS et CHANNEL_AMOUNT avant d'exécuter cette fonction.

## Contact

Pour toute question ou préoccupation, veuillez contacter invest-master à contact.investmaster@gmail.com.

