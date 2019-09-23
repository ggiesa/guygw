# Arrays

Fundamentally, arrays are sequential portions of memory that are allocated to store associated data. You can think of arrays as a group of related variables that are stored together in a sequence.

In Python, lists are implementations of dynamic referential arrays. Practically, this means that the memory allocated to the array will grow according to the size of the array (no need to specify the size of the array when initializing), and each cell of the array stores a reference to data, rather than the data itself.

Lists store pointers to the data it is initialized with:
```python
import ctypes
a = "red"
lst = [a]

# The list contains a reference to the original variable, a, rather than a
# a new "red" string itself.
print(hex(id(a)))      # String "red" stored at address 0x11026d4f0
print(hex(id(lst[0])))   # List references the same address: 0x11026d4f0
```

And the memory allocated to a list will grow with the size of the list:
```python
import sys

lst = []
for i in range(7):
  print(f'Size of list with {i} elements: {sys.getsizeof(lst)} bytes')
  lst.append(i)

# Output:
# Size of list with 0 elements: 72 bytes
# Size of list with 1 elements: 104 bytes
# Size of list with 2 elements: 104 bytes
# Size of list with 3 elements: 104 bytes
# Size of list with 4 elements: 104 bytes
# Size of list with 5 elements: 136 bytes
# Size of list with 6 elements: 136 bytes
```
