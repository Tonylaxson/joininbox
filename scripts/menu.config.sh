#!/bin/bash

source /home/joinmarket/joinin.conf
source /home/joinmarket/_functions.sh

# BASIC MENU INFO
HEIGHT=10
WIDTH=58
CHOICE_HEIGHT=20
TITLE="Configuration options"
MENU=""
OPTIONS=()
BACKTITLE="JoininBox GUI"

# Basic Options
OPTIONS+=(
  JMCONF "Edit the joinmarket.cfg manually"
  CONNECT "Connect to a remote bitcoin node on mainnet"
  SIGNET "Switch to signet with a local Bitcoin Core"
  RESET "Reset the joinmarket.cfg to the defaults"
)

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

case $CHOICE in
  JMCONF)
    /home/joinmarket/install.joinmarket.sh config
    echo "Returning to the menu..."
    sleep 1
    /home/joinmarket/menu.sh
    ;;
  RESET)
    echo "# Removing the joinmarket.cfg"
    rm -f /home/joinmarket/.joinmarket/joinmarket.cfg
    generateJMconfig
    echo         
    echo "Press ENTER to return to the menu..."
    read key
    ;;
  CONNECT)
    /home/joinmarket/install.bitcoincore.sh signetOff
    /home/joinmarket/menu.bitcoinrpc.sh
    echo         
    echo "Press ENTER to return to the menu..."
    read key
    ;;
  SIGNET)
    /home/joinmarket/install.bitcoincore.sh signetOn
    echo         
    echo "Press ENTER to return to the menu..."
    read key
    ;;
esac