/* This program sums the prime numbers up to the parameter given from command line. */
/* gcc primus.c */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
   int i, sum = 2, prm = atoi(argv[1]);
   for(i = 3; i < prm; i++)
   {
      int j;
      int flag = 1;
      for(j = i - 1; j > 1; j--)
      {
         if(i % j == 0)
         {
            flag = 0;
            break;
         }
      }

      if(flag == 1)
         sum += i;
         
   }
   printf("The sum is: %d\n", sum);
}

