"""A simple implementation of a dynamic array"""
import ctypes

class DynamicArray:
    def __init__(self):
        self._len = 0
        self.capacity = 1
        self.A = self._make_array(self.capacity)

    def __len__(self):
        return self._len

    def __getitem__(self, k):
        return self.A[k]

    def append(self, item):
        """Append an item to the list; resize if necessary."""
        if self._len == self.capacity:
            self._resize(2*self.capacity)

        self.A[self._len] = item
        self._len += 1

    def _resize(self, new_capacity):
        """Create a new list with capacity <new_capacity>"""
        B = self._make_array(new_capacity)
        for i in range(self._len):
            B[i] = self.A[i]
        self.A = B
        self.capacity = new_capacity

    def _make_array(self, capacity):
        return (capacity * ctypes.py_object)()
