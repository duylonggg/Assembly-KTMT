# Assembly-KTMT

Cài đặt wsl và Ubuntu

1. wsl --install
2. sudo apt update
3. sudo apt install nasm

Chạy chương trình:
- nasm -f elf32 file.asm: Dich sang file .o
- ld -m elf_i386 -s -o file.exe file.o: Dich sang file .exe
- ./file.exe: Chay file exe