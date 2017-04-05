OBJS = insertion_sort.s
ASM = nasm
FLAGS = -f elf -g3
OBJ_NAME = insertion_sort.o
EXE_NAME = insertion_sort
LINK = ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -o $(EXE_NAME) $(OBJ_NAME) -lc

all:
	$(ASM) $(FLAGS) $(OBJS)

link:
	$(LINK)

clean:
	rm $(OBJ_NAME)
	rm $(EXE_NAME)

