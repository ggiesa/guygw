class Stack:
    def __init__(self):
        self.data = []

    def __repr__(self):
        return str(self.data)

    def push(self, item):
        self.data.append(item)

    def pop(self):
        val = self.data[-1]
        self.data = self.data[:-1]
        return val

    def peek(self):
        return self.data[-1]
