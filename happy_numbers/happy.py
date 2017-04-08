# Happy number finder.

def isHappy(number):
   summary = 0
   while(number != 0):
      n = number % 10;
      summary += n * n
      number /= 10

   print(summary)
   if summary == 1:
      return True
   elif summary == 4:
      return False
   else:
      return isHappy(summary)

isHappy(206)
   
