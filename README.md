# ATTENTION!!
# THIS SCRIPT IS ONLY COMPATIBLE WITH LINUX (AND MAYBE MACOS)!!



# QEMU_Vm_Creator
Create QEMU VMs automatically!!!

# Step 1. Creating the Virtual Disk

To Create the Virtual Disk, just cd to the Vm_Creator directory typing in Terminale:

`cd <path/to/Vm_Creator>`

Then, type:

`sudo sh create_hard_drive.sh`
  
Now, you have created your 40 GB hard drive, if you want smaller or bigger, type:

`qemu-img resize -f qcow2 Qemu_Disk.img 60G`

Replace 60G with your preferred size.

# Step 2. Starting up the VM
  
To start up the VM we have three options:

  Run VM from hard drive;
  
  Run VM from cdrom;
  
  Run from ISO.
  
# Step 3a. Starting up from ISO

Obviously, to start up QEMU, we need to install a OS.

We can do that from ISO file.

But you need to tell QEMU what ISO 
