#!/bin/bash
#
# This script will install Bitcoin Core and Umbrel on a clean Ubuntu server
# Version: 0.1.0
# Author: invest-master <contact.investmaster@gmail.com>

set -eo pipefail

# Variables
umbrel_branch="master"  # Change this to use a different branch of Umbrel
bitcoin_version="22.0"  # Change this to use a different version of Bitcoin Core
umbrel_dir="$HOME/umbrel"
umbrel_env_path="$umbrel_dir/.env"
umbrel_start_script_path="$umbrel_dir/scripts/start"
bitcoin_dir="$umbrel_dir/bitcoin"
bitcoin_conf_file="$bitcoin_dir/bitcoin.conf"
bitcoin_download_url="https://bitcoincore.org/bin/bitcoin-core-${bitcoin_version}/bitcoin-${bitcoin_version}-x86_64-linux-gnu.tar.gz"
bitcoin_download_file="$HOME/bitcoin-${bitcoin_version}-x86_64-linux-gnu.tar.gz"
bitcoin_signature_url="https://bitcoincore.org/bin/bitcoin-core-${bitcoin_version}/SHA256SUMS.asc"
bitcoin_signature_file="$HOME/bitcoin-${bitcoin_version}-SHA256SUMS.asc"
bitcoin_fingerprint="01EA5486DE18A882D4C2684590C8019E36C2E964"

main() {
    check_is_root
    install_dependencies
    download_and_verify_bitcoin
    create_umbrel_dir
    download_umbrel
    install_umbrel
    setup_umbrel
    start_umbrel
    echo "Umbrel and Bitcoin Core installation complete!"
}

check_is_root() {
    if [[ "${EUID}" -ne 0 ]]; then
        printf "ERROR: You must run this script as root.\n\n$ sudo bash ubuntu-Umbrel-Bitcoin-Node-Installer.sh\n"
        exit 1
    fi
}

install_dependencies() {
    printf "Installing dependencies...\n"
    apt-get update && apt-get install -y \
        curl \
        gnupg \
        python3 \
        python3-pip \
        python3-venv \
        software-properties-common \
        tor \
        wget
}

download_and_verify_bitcoin() {
    printf "Downloading and verifying Bitcoin Core...\n"
    curl -SLO "${bitcoin_download_url}"
    curl -SLO "${bitcoin_signature_url}"
    # Verify PGP signature
    gpg --keyserver keyserver.ubuntu.com --recv-keys ${bitcoin_fingerprint}
    gpg --verify "${bitcoin_signature_file}" || { echo "ERROR: Failed to verify Bitcoin Core signature!"; exit 1; }
    # Verify SHA256 sum
    sha256sum -c --ignore-missing "${bitcoin_signature_file}" || { echo "ERROR: Failed to verify Bitcoin Core SHA256 sum!"; exit 1; }
    # Extract archive
    tar -xzf "${bitcoin_download_file}" -C "${HOME}"
}

create_umbrel_dir() {
    printf "Creating Umbrel directory...\n"
    mkdir -p "$umbrel_dir"
}

download_umbrel() {
    printf "Downloading Umbrel...\n"
    git clone --branch "${umbrel_branch}" https://github.com/getumbrel/umbrel.git "$umbrel_dir"
}

install_umbrel() {
    printf "Installing Umbrel...\n"
    cd "$umbrel_dir"
    ./scripts/install.sh --without-sentry
    cd "$HOME"
}

setup_umbrel() {
    printf "Setting up Umbrel...\n"
    # Configure Bitcoin Core
    printf "server=1\nregtest=0\nrpcuser=${RPC_USER}\nrpcpassword=${RPC_PASSWORD}\n" >> "${BITCOIN_DATA_DIR}/bitcoin.conf"

    # Start Bitcoin Core
    printf "Starting Bitcoin Core...\n"
    /usr/bin/bitcoind -daemon -datadir="${BITCOIN_DATA_DIR}"

    # Wait for Bitcoin Core to start
    printf "Waiting for Bitcoin Core to start...\n"
    sleep 5s

    # Create a new wallet
    printf "Creating a new wallet...\n"
    bitcoin-cli -datadir="${BITCOIN_DATA_DIR}" -rpcwallet="${WALLET_NAME}" createwallet "${WALLET_NAME}"

    # Generate a new address
    printf "Generating a new Bitcoin address...\n"
    NEW_ADDRESS=$(bitcoin-cli -datadir="${BITCOIN_DATA_DIR}" -rpcwallet="${WALLET_NAME}" getnewaddress)

    # Configure LND
    printf "Configuring LND...\n"
    printf "bitcoin.${NETWORK}.active=1\nbitcoin.${NETWORK}.${CHAIN}=1\nbitcoin.${NETWORK}.rpcuser=${RPC_USER}\nbitcoin.${NETWORK}.rpcpass=${RPC_PASSWORD}\n" >> "${LND_DATA_DIR}/lnd.conf"

    # Create a new LND wallet
    printf "Creating a new LND wallet...\n"
    lncli --network="${NETWORK}" create

    # Wait for LND to start
    printf "Waiting for LND to start...\n"
    sleep 5s

    # Unlock LND wallet
    printf "Unlocking LND wallet...\n"
    lncli --network="${NETWORK}" unlock

    # Open a channel with a node on the Lightning Network
    printf "Opening a channel with a node on the Lightning Network...\n"
    lncli --network="${NETWORK}" connect "${NODE_PUBKEY}@${NODE_ADDRESS}"
    lncli --network="${NETWORK}" openchannel "${NODE_PUBKEY}" "${CHANNEL_AMOUNT}"

    printf "\nSetup complete!\n\n"
}


