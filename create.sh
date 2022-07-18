#!/bin/bash

sleep 1
clear

echo "Welcome to the brand-new QEMU VM Creator!"
sleep 1
echo "First, you have to make sure that you have these packages installed:"
echo ""
echo "  qemu"
echo "  qemu-utils"
echo "  qemu-system"
echo ""
echo "Are you sure to continue? [y/n]"
read qemu

if [[ $qemu == "y" ]]; then
    sleep 1
    echo ""
    echo "Perfect! Now we can start!"

    echo "Enter your virtual disk size in GBytes (e.g. 60, 5, 400, etc.):"
    read disk
    sleep 1

    echo "Enter RAM size in MBytes (e.g. 1024, 8192, 4096 etc.):"
    read ram
    RAM=`expr $ram / 1024`
    sleep 1

    echo "Calculating sizes"
    sleep 1

    echo "These are your settings:"
    echo "HDD: $disk GB"
    echo "RAM: $RAM GB"
    echo ""
    sleep 1

    echo "[1] qemu-system-x86_64"
    echo "  QEMU for Intel x64 emulation"
    echo ""
    echo "[2] qemu-system-i386"
    echo "  QEMU for Intel 32-bit emulation"
    echo ""
    echo ""
    sleep 2

    echo "Type a number correponding to the emulator architecture:"
    read arch
    if [[ $arch == "1" ]]; then
        cpu='qemu-system-x86-64'
    elif [[ $arch == "2" ]]; then
        cpu='qemu-system-i386'
    else
        echo "Error 02: not a valid architecture. Quitting."
        sleep 2
        exit
    fi

    sleep 1

    echo "Now, drag your image file here, then press enter(it doesn't have to be in the same directory of the VM):"
    read iso

    sleep 1

    echo "OK, now i'm preparing your VM script..."

    mkdir VM
    sleep 0.3
    cd VM
    sleep 0.3
    qemu-img create -f qcow2 Qemu-HDD.img $disk'G'
    sleep 0.3

    touch boot_cdrom.sh
    echo "$cpu -hda Qemu-HDD.img -cdrom $iso -m $ram -boot d" > boot_cdrom.sh
    sleep 0.3
    sudo chmod +x boot_cdrom.sh

    touch boot_hdd.sh
    echo "$cpu -hda Qemu-HDD.img -cdrom $iso -m $ram -boot c" > boot_hdd.sh
    sudo chmod +x boot_hdd.sh

    cd ..

    sleep 2

    echo "Creation of the VM was successfull!"
    sleep 0.5
    echo "Now, enter in the <VM> folder and choose how to boot the VM:"
    echo ""
    echo ""
    sleep 0.5
    echo "  boot_cdrom.sh         Boot from the CD-ROM (to install the OS)"
    echo "  boot_hdd.sh           Boot from the HDD"
    sleep 1
    echo "That's all! See you next time!"
    sleep 1
    exit

elif [[ $qemu == "n" ]]; then
        sleep 1
        echo ""
        echo "Please install these packages with:"
        echo ""
        echo "sudo apt install qemu qemu-utils qemu-system"
        sleep 1
        exit
else
    echo "Error 01: Not valid answer. Quitting."
    sleep 2
    exit
fi