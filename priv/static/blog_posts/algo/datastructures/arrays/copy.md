# Arrays

Fundamentally, arrays are sequential portions of memory that are allocated to store associated data. You can think of arrays as a group of related variables that are stored together in a sequence.  



## Python
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


Python's data structures are mutable, so we're free to modify a list's elements in place and we're only required to make a complete copy of the array when the size of the array exceeds the memory allocated to the array and we need to resize:
```python
import sys

lst = []
for i in range(7):
  print(f'Size of list with {i} elements: {sys.getsizeof(lst)} bytes')
  lst.append(i)

# Output:
# Size of list with 0 elements: 72 bytes
# Size of list with 1 elements: 104 bytes
# ...
# Size of list with 5 elements: 136 bytes
```

Under the hood, this is done by creating a new array that's 2x the size of the original array, and then setting the new arrays' elements to the originals'.  

Many languages (Golang for example) will automatically pass copies of arrays to functions so as to prevent mutating the original array within the scope of the function. Python doesn't do this, so functions are free to mutate the original array:

```python
def append_one(lst):
  lst.append(1)

a = [1,2,3]
append_one(a)
print(a) # [1,2,3,1]
```

## Go

Golang implements two main array-based data structures: arrays and slices.

Golang arrays are standard fixed-size arrays. Initializing a new array requires that you specify the size of the array, and then each element is initialized to the zero-value of the given datatype. Unlike Python lists, Golang arrays aren't referential; elements don't reference data stored elsewhere in memory, they *are* the data.
```golang
var a [3]int
var c = 5

a[0] = c
fmt.Println(&c) // 0xc000098008 -- location of c
fmt.Println(&a[0]) // 0xc0000a2000 -- array doesn't reference c; the value of c is copied and actually added to a

```

Golang slices are a little more similar to Python's lists. They're dynamic (no need to specify the capacity when initializing), and under the hood they reference an underlying array. A slice is essentially a struct with three fields: a pointer to the underlying array, the length of the underlying array, and the capacity of the underlying array. When appending elements to a slice we can see how the capacity of the slice grows:
```golang
var a []int
fmt.Println("Length of slice | Capacity")
for i := 0; i < 10; i++ {
  a = append(a, 1)
  fmt.Println(len(a), "|", cap(a))
}
// Length of slice | Capacity
// 1 | 1
// 2 | 2
// 3 | 4
// 4 | 4
// 5 | 8
// ...
// 9 | 16
```
Like Python, every time the capacity of the slice needs to increase, a new array is allocated with twice the capacity of the original array, and then the contents of the original array are copied over to the new array.  

Unlike Python, Go automatically copies an array when it's passed into a function, so the original array won't be modified by a function like this:
```golang
func main() {
  var a = []int{4,3,2}
  var b = append_one(a)
  fmt.Println("Original array:", a)
  fmt.Println("Output from function:", b)
}

func append_one(slice []int) []int {
  return append(slice, 1)
}

// Output:
// Original array: [4 3 2]
// Output from function: [4 3 2 1]
```

One interesting thing to note about Go is that the language doesn't allow arrays to be initialized dynamically. In other words, we can't initialize an array with a capacity that's defined by a variable that may change at runtime. If we want to resize an array dynamically, we're forced to use slices.

## Elixir

Elixir implements its linear data structures as linked lists rather than actual arrays, which is common for functional languages with immutable data structures. This is because, if we enforce true immutability in our array operations, we suddenly need to create a complete copy of the target array with each operation. This can become very expensive with arrays because we constantly need to find sequences of memory to store the entire array. If we consider the idea of creating a copy of the entire array each time we want to update an element, it becomes apparent that this would be an expensive proposition.

Linked lists are better suited to the immutable data paradigm in part because nodes of the list are stored in memory with no relation to one another other than pointing to the next node, and the nodes composing the list are themselves immutable.  

This means that we can reuse tail nodes freely when composing new lists:
```elixir
list1 = [0,1]
list2 = [2,3,4]
list3 = list1 ++ list2 # [0,1,2,3,4]
```
Because nodes are immutable, we can safely reuse all of list2 when composing list3; we're only required to make a copy of list1 when we do this concatenation. More on this in the Linked List section.
