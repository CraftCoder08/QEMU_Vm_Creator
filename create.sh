#!/bin/bash

dev=$1

sleep 1
clear

# Check for log mode

    if ! [[ -z "$1" ]]; then
        if [[ $dev == "-v" ]]; then
            echo "It seems that you have verbose mode enabled, this will output the VM creation process."
            sleep 2
        else
            echo "Not a valid argument"
        fi
    fi
# Welcome!

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

    echo ""
    sleep 1
    clear
    echo "Perfect! Now we can start!"
    sleep 1
    echo ""

    sleep 1

    echo "Enter your virtual disk size in GBytes (e.g. 60, 5, 400, etc.):"
    read disk                           # Save disk size as variable
    echo ""
    sleep 1

    echo "Enter RAM size in MBytes (e.g. 1024, 8192, 4096 etc.):"
    read ram                            # Save RAM size as variable
    RAM=`expr $ram / 1024`		        # Calculate RAM Size in GB (e.g. 2048 / 1024 = 2 GB)
    echo ""
    sleep 1

    echo "[1] qemu-system-x86_64"
    echo "  QEMU for Intel x64 emulation"
    echo ""
    echo "[2] qemu-system-i386"
    echo "  QEMU for Intel 32-bit emulation"
    echo ""
    echo ""

    echo "Type a number correponding to the emulator architecture:"
    read arch
    if [[ $arch == "1" ]]; then
        cpu='qemu-system-x86_64'
    elif [[ $arch == "2" ]]; then
        cpu='qemu-system-i386'
    else
        echo "Error 02: not a valid architecture. Quitting."
        sleep 2
        exit
    fi

    echo ""

    sleep 1

    echo "Now, drag your image file here, then press enter (it doesn't have to be in the same directory of the VM):"
    read iso                            # Save ISO image file directory

    echo ""

    sleep 1

    echo "Calculating sizes"
    echo ""
    sleep 2

    echo "These are your settings:"
    echo ""
    echo "VM name: $vm"
    echo "HDD: $disk GB"
    if [[ $RAM < 1 ]]; then
        echo "RAM: $ram MB"             # Print RAM size in MB if minor than 1 GB
    else    
        echo "RAM: $RAM GB"             # Print RAM size normally
    fi
    if [[ $arch == "1" ]]; then
        echo "CPU architecture: Generic Intel 64-bit"   # Print x64 CPU Architecture   
    elif [[ $arch == "2" ]]; then
        echo "CPU architecture: Generic Intel 32-bit"   # Print x86 CPU Architecture   
    fi
    echo "ISO image path: $iso"
    echo ""
    echo "Press Enter to continue..."
    read enter
    echo ""
    sleep 1

    echo "OK, now i'm preparing your VM script..."

    mkdir VM

    cd VM

    sleep 0.3


    sleep 0.3
    if ! [[ -z "$1" ]]; then
        if [[ $dev == "-v" ]]; then
            echo "Creating QEMU VHD"
            sleep 0.5
        fi
    fi
    qemu-img create -f qcow2 Qemu-HDD.img $disk'G'
    sleep 0.3

    if ! [[ -z "$1" ]]; then
        if [[ $dev == "-v" ]]; then
            echo "Creating boot scripts"
            sleep 0.5
        fi
    fi
    touch boot_cdrom.sh                                 # Create executable CD-ROM_boot file
    touch boot_hdd.sh                                   # Create executable HDD_boot file

    if ! [[ -z "$1" ]]; then
        if [[ $dev == "-v" ]]; then
            echo "Writing boot files"
            sleep 0.5
        fi
    fi
    
    echo "#!/bin/bash" > boot_cdrom.sh
    echo "#!/bin/bash" > boot_hdd.sh
    echo "$cpu -hda Qemu-HDD.img -cdrom $iso -m $ram -boot d" >> boot_cdrom.sh
    echo "$cpu -hda Qemu-HDD.img -cdrom $iso -m $ram -boot c" >> boot_hdd.sh
    echo ""
    echo ""
    
    if ! [[ -z "$1" ]]; then
        if [[ $dev == "-v" ]]; then
            echo "Making the files executable"
            sleep 0.5
        fi
    fi
    
    echo ""
    echo "For <chmod> command, is required sudo password."

    sudo chmod +x boot_cdrom.sh                         # Make the file executable
    sudo chmod +x boot_hdd.sh                           # Make the file executable

    sleep 2

    clear

    echo "Creation of the VM was successfull!" 
    echo "Hi. This file has been made from the VM creation script." > readme.txt
    echo "" >> readme.txt
    sleep 2
    echo "Now, enter in the <VM> folder and choose how to boot the VM:"
    echo "Type one of these commands in the terminal after you <cd> in this directory:" >> readme.txt
    echo "" >> readme.txt
    echo ""
    echo ""
    sleep 0.5
    echo "  boot_cdrom.sh         Boot from the CD-ROM (to install the OS)"
    echo "./boot_cdrom.sh   <----- This is for booting from the CD-ROM (to install the OS)" >> readme.txt
    echo "./boot_hdd.sh     <----- This is for booting from the HDD (after installing the OS)" >> readme.txt
    echo "  boot_hdd.sh           Boot from the HDD"

    sleep 1
    echo ""
    echo ""
    echo "That's all! See you next time!"

    sleep 1
    exit

elif [[ $qemu == "n" ]]; then
        sleep 1
        echo ""
        echo "Please install these packages with:"
        echo ""
        echo "sudo apt install qemu-utils qemu-system           For Debian/Ubuntu systems"
        echo "sudo pacman -Syu qemu-full                        For Arch Linux systems"
        echo "sudo dnf -y install qemu                          For Fedora/Redhat systems"
        echo "sudo zypper install qemu                          For OpenSUSE systems"

        sleep 1
        exit
else
    echo "Error 01: Not valid answer. Quitting."
    sleep 2
    exit
fi
