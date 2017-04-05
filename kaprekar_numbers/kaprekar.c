/* This program finds Kaprekar numbers up to the parameter given from command line. */
/* $ gcc kaprekar.c -lm */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int digit_count(int number)
{
   int n = 0;
   while(number != 0)
   {
      n++;
      number /= 10;
   }
   return n;
}

int is_kaprekar(int number)
{
   int square = number * number;
   int n = digit_count(number);
   int l = square / pow(10, n);
   int r = square % (int)pow(10, n);

   if(l + r == number)
   {
      printf("%d\n", number);
      return 1;
   }
   return -1;
}

int main(int argc, char *argv[])
{
   int number = atoi(argv[1]);
   int i;
   for(i = 1; i < number; i++)
   {
      is_kaprekar(i);  
   }
   return 0;
}
