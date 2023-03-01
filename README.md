
#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install necessary packages
sudo apt install build-essential curl git gnupg-agent -y

# Create directory and move to it
mkdir umbrel_install
cd umbrel_install

# Download Umbrel installer
-curl -L https://github.com/getumbrel/umbrel/raw/master/scripts/install > ubuntu-umbrel-bitcoin-node-installer.sh
-sudo bash ubuntu-umbrel-bitcoin-node-installer.sh


# Verify SHA256SUM


# Run Umbrel installer
bash ubuntu-umbrel-bitcoin-node-installer.sh

# fichier "bitcoin.conf"
Pour créer le dossier .bitcoin et le fichier bitcoin.conf, vous pouvez suivre les étapes suivantes :

Ouvrez un terminal sur votre système Ubuntu.

Utilisez la commande mkdir pour créer un dossier`.bitcoin`dans votre répertoire personnel :

mkdir ~/umbrel-install/.bitcoin


-Naviguer jusqu'au dossier .bitcoin en tapant la commande suivante :
bash

cd ~/umbrel-install/.bitcoin

-Vérifier si le fichier bitcoin.conf existe déjà avec la commande suivante :

ls | grep bitcoin.conf

Utilisez la commande nano pour créer et ouvrir le fichier bitcoin.conf dans le dossier .bitcoin :

nano ~/umbrel-install/.bitcoin/bitcoin.conf

Ajoutez les paramètres de configuration à ce fichier en fonction de vos besoins. Voici quelques exemples de paramètres couramment utilisés :
file
rpcuser=<nom d'utilisateur>
rpcpassword=<mot de passe>
rpcport=<port>
Assurez-vous de remplacer <nom d'utilisateur> et <mot de passe> par des valeurs de votre choix. Vous pouvez également spécifier un <port> différent si vous le souhaitez.

Une fois que vous avez ajouté tous les paramètres de configuration nécessaires, enregistrez le fichier en appuyant sur CTRL+X, suivi de Y, puis appuyez sur Entrée.

Votre fichier bitcoin.conf est maintenant créé et prêt à être utilisé par votre portefeuille Bitcoin.

## Variables d'environnement

Notez que vous devrez fournir les variables nécessaires telles que RPC_USER, RPC_PASSWORD, WALLET_NAME, NETWORK, CHAIN, BITCOIN_DATA_DIR, LND_DATA_DIR, NODE_PUBKEY, NODE_ADDRESS et CHANNEL_AMOUNT avant d'exécuter cette fonction.

## Contact

Pour toute question ou préoccupation, veuillez contacter invest-master à contact.investmaster@gmail.com.

