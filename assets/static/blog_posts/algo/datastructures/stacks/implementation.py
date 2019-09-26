class Stack:
    def __init__(self, data=None):
        self.data = data or []

    def __repr__(self):
        return str(self.data)

    def push(self, item):
        """Append an element to the end of the array"""
        self.data.append(item)

    def pop(self):
        """Remove the last element from the array and return it"""
        val = self.data[-1]
        self.data = self.data[:-1]
        return val

    def peek(self):
        """Return the last element of the array but don't remove it"""
        return self.data[-1]
