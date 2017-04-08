# x86 Linux Assembly Program Examples using NASM

Here are some Linux Assembly program examples. They include the use of labels, procedures, variables, stack operations and so on. Every program has a Makefile to be compiled. After cd'ing into the related directory, you can issue the following to get your 32-bit elf executable:

```
$ make
$ make link
```

What Makefile does is a simple compile/link procedure. And it is like the following:

```
$ nasm -f elf -g example.s
$ ld -m elf_i386 -o example example.o
```

Please note that, in examples that printf is used, the parameters change like the following:

```
$ nasm -f elf -g example.s
$ ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 -o example example.o -lc
```

You can clear the directory from object files and executables issuing:

```
$ make clean
```

## Numbers That Are Divisible by 2 and 3
This example shows simple div and jmp operations and calculates the sum of the numbers that are divisible by 2 and 3 up to the value defined in one of the registers. This example also contains corresponding c code.

   * [div\_2\_3.s](/numbers_that_are_divisible_by_2_3/div_2_3.s)
   * [div\_2\_3.c](/numbers_that_are_divisible_by_2_3/div_2_3.c)


## Prime Numbers
This program finds [prime numbers](https://en.wikipedia.org/wiki/Prime_number) up to a specified value (max. 8 bits). It also uses printf function for printing out the numbers. Also there is a c version of the code.

   * [prime.s](/prime_numbers/prime.s)  
   * [primus.c](/prime_numbers/primus.c)


## Palindromic Numbers
This program finds [palindromic numbers](https://en.wikipedia.org/wiki/Palindromic_number) up to 4 digits. It uses printf to write the numbers to the screen.

   * [palindrome.s](/palindrome/palindrome.s)


## Kaprekar Numbers
This program finds [Kaprekar numbers](https://en.wikipedia.org/wiki/Kaprekar_number) up to 1000. Also there is a c version of this program.

   * [kaprekar.s](/kaprekar_numbers/kaprekar.s)
   * [kaprekar.c](/kaprekar_numbers/kaprekar.c)


## Happy Numbers
This program finds [happy numbers](https://en.wikipedia.org/wiki/Happy_number) 200 through 300. It uses printf to write the number to the stdout. There also is a Python example of finding happy numbers.

   * [happy\_numbers.s](/happy\_numbers/happy\_numbers.s)
   * [happy.py](/happy\_numbers/happy.py)


## Insertion Sort
This program implements [insertion sort](https://en.wikipedia.org/wiki/Insertion_sort) on a given array of integers. Unfortunately it doesn't print anything to stdout. One can examine memory to see the effect with a debugger like [gdb](https://www.gnu.org/software/gdb/).


   * [insertion\_sort.s](/insertion\_sort/insertion\_sort)


## Binary Search
This is an implementation example of [binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm) for given a sorted array. It also shows little examples of using variables, loading effective addresses and working with array indexes. It prints out "found" or "not found" according to the result of the search.

   * [binary\_search.s](/binary\_search/binary\_search.s)


Useful Links
============
A lot of useful information about Linux Assembly and related tutorials can be found at [this](http://asm.sourceforge.net) web site. This site is really helpful.

If you find bugs, please let me know. Thanks!

