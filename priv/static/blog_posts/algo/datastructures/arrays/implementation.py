"""A simple implementation of a dynamic array"""
import ctypes

class DynamicArray:
    def __init__(self):
        self.n = 0
        self.capacity = 1
        self.A = self.make_array(self.capacity)

    def __len__(self):
        return self.n

    def __getitem__(self, k):
        return self.A[k]

    def append(self, item):
        if self.n == self.capacity:
            self._resize(2*self.capacity)

        self.A[self.n] = item
        self.n += 1

    def _resize(self, new_capacity):
        B = self.make_array(new_capacity)
        for i in range(self.n):
            B[i] = self.A[i]
        self.A = B
        self.capacity = new_capacity

    def make_array(self, capacity):
        return (capacity * ctypes.py_object)()
