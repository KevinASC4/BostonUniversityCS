'''
Kevin Lopez Sepulveda
CS677
HW1
'''
import string
import math
#Question 1a
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
ansNum1 = [x**2 for x in numbers]
print("Original List: ", numbers, "\n New List: ",ansNum1)
#Question 1b
fruits = ['green apple', 'banana', 'cherry', 'date']
ansNum2 = [fruit.title() for fruit in fruits]
print("Original List: ", fruits, "\n New List: ",ansNum2)
#Question 1c
ansNum3 = { 
    outer: {char: outer * (ord(char) - ord('a') + 1) for char in 'abc'} 
    for outer in range(1, 4)
}
print("Question 1C:",ansNum3)
#Question 2a
def binary_to_decimal(q2a):
    return list(map(lambda b: int(b, 2), q2a))
binaries = ['1010', '1111', '0001', '100000']
decimal_values = binary_to_decimal(binaries)
print("Binary values:",binaries,"\n decimal values:",decimal_values)
#Question 2b
def filter_palindromes(q2b):
    return list(filter(lambda word: word == word[::-1], q2b))
words = ['level', 'world', 'deified', 'python', 'radar']
palindromes = filter_palindromes(words)
print("Original List:",words,"\n Palindromed words:", palindromes)
#Question 2C
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
squared_evens = list(map(lambda x: x**2, filter(lambda x: x % 2 == 0, numbers)))
print("Original List:",numbers,"\n New List",squared_evens)
#Question 2d
numbers2d = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 24, 29, 31]
prime_numbers = list(filter(lambda n: n > 1 and all(n % i != 0 for i in range(2, int(n**0.5) + 1)), numbers2d))
print("Original List:",numbers2d,"\n New list:",prime_numbers)
#Question 3a
with open("gettysburg.txt", "r") as file:
    contents = file.read()
#Question 3b
def speech_to_list(text):
    words = []
    for line in text.split("\n"):  
        words.extend(line.split()) 
    return words
speech_list = speech_to_list(contents)
print(speech_list)
print("There are ", len(speech_list),"contents in speech list")
#Question 3d
def speech_to_list_better(text):
    words = []
    for line in text.split("\n"):
        for word in line.split():
            if word != "--":  
                words.append(word)
    return words
speech_list_better = speech_to_list_better(contents)
print("There are ", len(speech_list_better),"contents in speech list better")
#Question 3e
def unique_words(word_list):
    unique_set = set()
    for word in word_list:
        cleaned_word = word.lower().strip(string.punctuation) 
        if cleaned_word:  
            unique_set.add(cleaned_word)
    return list(unique_set)
speech_list_unique = unique_words(speech_list_better)
#Question 4a
class Vector:
    def __init__(self, coordinates=None, dimension=2):
        if coordinates is None:
            self.coordinates = [0.0] * dimension  
        else:
            self.coordinates = coordinates
        self.dimension = len(self.coordinates)  
#Question 4b
    def distance(self, other):
        if self.dimension != other.dimension:
            raise ValueError("Vectors must have the same dimension.")
        
        return math.sqrt(sum((a - b) ** 2 for a, b in zip(self.coordinates, other.coordinates)))

    def vector_sum(self, other):
        if self.dimension != other.dimension:
            raise ValueError("Vectors must have the same dimension.")
        
        return Vector([a + b for a, b in zip(self.coordinates, other.coordinates)])
    #Question 4c
    '''
    The __str__ function allows you to represent an object in the function into a string format
    '''
    def __str__(self):
        return f"Vector({self.coordinates})"
#Question 4d
x = Vector([1.0, -1.0, 3.0, 5.0, -2.2])
y = Vector([0.0, 0.0, 0.0, 0.0, 0.0])
distance_x_y = x.distance(y)
print("Distance between x and y:", distance_x_y)
z = x.vector_sum(y)
length_z = math.sqrt(sum(c**2 for c in z.coordinates))
print("Length of vector z:", length_z)
print("Coordinates of z:", z)
