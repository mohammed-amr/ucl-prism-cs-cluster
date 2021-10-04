import sys

print("Hello from beyond!")


print("Here's your data:")
file = open(sys.argv[1] + '/testData.txt', 'r')
Lines = file.readlines()
print(Lines[0]) 
