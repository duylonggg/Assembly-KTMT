# Assembly-KTMT

Cài đặt wsl

Cài đặt Ubuntu

Unbuntu là trình duyệt mặc định wsl

wsl --install
sudo apt update
sudo apt install nasm

Chạy chương trình:
- nasm -f elf32 file.asm: Dich sang file .o
- ld -m elf_i386 -s -o file.exe file.o: Dich sang file .exe
- ./file.exe: Chay file exe