OBJS = div_2_3.s
ASM = nasm
FLAGS = -f elf -g 
OBJ_NAME = div_2_3.o
EXE_NAME = div_2_3
LINK = ld -m elf_i386 -o $(EXE_NAME) $(OBJ_NAME)

all:
	$(ASM) $(FLAGS) $(OBJS)

link:
	$(LINK)

clean:
	rm $(OBJ_NAME)
	rm $(EXE_NAME)

