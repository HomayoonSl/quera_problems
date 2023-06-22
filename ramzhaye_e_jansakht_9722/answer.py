from math import isqrt

numbers_str = ['1', '3', '7', '9']
strong = ['2', '3', '5', '7']
length = int(input())


def prime(number):
    if number == 1:
        return False
   
   for p in range(2, isqrt(number) + 1):
        if number % p == 0:
            return False

    return True

    for i in strong:
        for number in numbers_str:
            n = i + number
            if prime(int(n)):
                strong.append(n)

    if len(i) == length:
        print(i)
    if len(i) == length + 1:
        break

