OBJS = kaprekar.s
ASM = nasm
FLAGS = -f elf -g 
OBJ_NAME = kaprekar.o
EXE_NAME = kaprekar
LINK = ld -m elf_i386 -o $(EXE_NAME) $(OBJ_NAME)

all:
	$(ASM) $(FLAGS) $(OBJS)

link:
	$(LINK)

clean:
	rm $(OBJ_NAME)
	rm $(EXE_NAME)

