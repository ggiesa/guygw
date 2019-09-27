class Deque:
    """A simple deque implementation using a list.
    The front of the deque is defined as the max index of the list"""

    def __init__(self, data=None):
        self.data = data or []

    def __repr__(self):
        return str(self.data[:100])

    def add_front(self, item):
        self.data.append(item)

    def add_rear(self, item):
        self.data.insert(0, item)

    def remove_front(self):
        return self.data.pop()

    def remove_rear(self):
        return self.data.pop(0)

    def is_empty(self):
        return self.data == []

    def size(self):
        return len(self.data)
