OBJS = happy_numbers.s
ASM = nasm
FLAGS = -f elf -g 
OBJ_NAME = happy_numbers.o
EXE_NAME = happy_numbers
LINK = ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -o $(EXE_NAME) $(OBJ_NAME) -lc

all:
	$(ASM) $(FLAGS) $(OBJS)

link:
	$(LINK)

clean:
	rm $(OBJ_NAME)
	rm $(EXE_NAME)

