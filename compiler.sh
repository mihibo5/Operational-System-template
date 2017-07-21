#!/bin/bash

#changing directory
printf "Changing directory";
cd ~/Desktop/NewOS-grub/isofiles/boot;

#compiling NASM
printf "\n\nCompiling NASM";
nasm -f elf64 multiboot_header.asm;
nasm -f elf64 boot.asm;
cd ~/Desktop/NewOS-grub/isofiles/boot;

#compiling C headers
printf "\n\nCompiling C headers"
gcc -m64 -o library.o -c library.h;
gcc -m64 -o memory_map.o -c memory_map.h;
gcc -m64 -o logic.o -c logic.h;
gcc -m64 -o colour.o -c colour.h;

#compiling C
printf "\n\nCompiling C"
gcc -m64 -o power.o -c ~/Desktop/NewOS-grub/isofiles/boot/lib/system/power.c
gcc -m64 -o wait.o -c ~/Desktop/NewOS-grub/isofiles/boot/lib/system/wait.c
gcc -m64 -o print.o -c ~/Desktop/NewOS-grub/isofiles/boot/lib/print.c
gcc -m64 -o kernel.o -c kernel.c;
#gcc -m64 -Wall ~/Desktop/NewOS-grub/isofiles/boot/lib/asm/print_char.o kernel.o

#linking C and NASM
printf "\n\nLinking C and NASM"
ld -n -o kernel.bin -T linker.ld multiboot_header.o boot.o kernel.o;

#creating bootable ISO
printf "\n\nCreating bootable ISO file\n";
cd ~/Desktop/NewOS-grub;
grub-mkrescue -o os.iso isofiles
printf "Bootable ISO created";

#removing temporary files
cd ~/Desktop/NewOS-grub/isofiles/boot;
printf "\nRemoving multiboot_header.o";
rm multiboot_header.o;
printf "\nRemoving boot.o";
rm boot.o;
printf "\nRemoving library.o";
rm library.o;
printf "\nRemoving colour.o";
rm colour.o;
printf "\nRemoving logic.o";
rm logic.o;
printf "\nRemoving memory_map.o";
rm memory_map.o;
printf "\nRemoving power.o";
rm power.o;
printf "\nRemoving wait.o";
rm wait.o;
printf "\nRemoving print.o";
rm print.o;
printf "\nRemoving kernel.o";
rm kernel.o;
printf "\nRemoving kernel.bin";
rm kernel.bin;

#copying to virtual machine
printf "\n\nCopying bootable ISO file to virtual machine"
cp -f ~/Desktop/NewOS-grub/os.iso ~/Dropbox/os.iso

#wait before exit
printf "\n\n";
read -n1 -r -p "Press any key to continue..." key;