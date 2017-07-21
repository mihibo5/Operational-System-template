#!/bin/bash
# 
#

#changing directory
printf "Changing directory";
cd ~/Desktop/NewOS-grub/isofiles/boot;

#compiling code
printf "\n\nCompiling";
nasm -f elf64 multiboot_header.asm
nasm -f elf64 boot.asm
ld -n -o kernel.bin -T linker.ld multiboot_header.o boot.o

#creating bootable ISO
printf "\n\nCreating bootable ISO file";
cd ~/Desktop/NewOS-grub;
grub-mkrescue -o os.iso isofiles
printf "Bootable ISO created";

#removing temporary files
cd ~/Desktop/NewOS-grub/isofiles/boot;
printf "\nRemoving multiboot_header.o";
rm multiboot_header.o;
printf "\nRemoving boot.o";
rm boot.o;
printf "\nRemoving kernel.bin";
rm kernel.bin;

#wait before exit
printf "\n\n";
read -n1 -r -p "Press any key to continue..." key;