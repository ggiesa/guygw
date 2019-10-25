class Queue:
    def __init__(self, data=None):
        self.data = data or []

    def __repr__(self):
        return str(self.data)

    def enqueue(self, item):
        """Insert an item at the start of the array"""
        self.data.insert(0, item)

    def dequeue(self):
        """Remove an element from the end of the array and return it"""
        return self.data.pop()

    def is_empty(self):
        return self.data == []

    def size(self):
        return len(self.data)
