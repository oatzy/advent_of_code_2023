import sys
from string import digits

numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

def first(line):
    for i in range(len(line)):
        for n in digits:
            if line[i] == n:
                return int(n)
        for n, name in enumerate(numbers, 1):
            if line[i:].startswith(name):
                return n


def last(line):
    for i in range(len(line), 0, -1):
        for n in digits:
            if line[i-1] == n:
                return int(n)
        for n, name in enumerate(numbers, 1):
            if line[:i].endswith(name):
                return n

def main():
    total = 0
    with open(sys.argv[1], 'r') as f:
        for line in f:
            line = line.strip()
            a, b = first(line), last(line)
            # print(line, a, b)
            total += 10 * a + b
    print(total)

if __name__ == '__main__':
    main()
