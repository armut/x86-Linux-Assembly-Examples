#include <stdio.h>

int main(int argc, char *argv[])
{
   int i, sum = 0;
   for(i = 0; i < 100; i++)
   {
      if(i % 3 == 0 && i % 2 == 0)
         sum += i;
   }
   printf("The sum is: %d\n", sum);
   return 0;
}
