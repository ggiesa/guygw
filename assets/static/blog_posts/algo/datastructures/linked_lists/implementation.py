class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None

    def __repr__(self):
        return str(self.data)


class LinkedList:
    def __init__(self, head=None):
        self.head = None
        self.size = 1 if head else 0

    def __len__(self):
        return self.size

    def __iter__(self):
        self._node = Node()
        self._node.next = self.head
        return self

    def __next__(self):
        if not self._node.next:
            raise StopIteration()
        self._node = self._node.next
        return self._node

    def __getitem__(self, ind):
        if not self.head:
            raise IndexError("List is empty")
        if ind > self.size-1:
            raise IndexError("Index out of bounds")
        if ind < 0:
            ind = self.size + ind
            if ind < 0:
                raise IndexError("Index out of bounds")

        for i, node in enumerate(self):
            if i == ind:
                return node

    def __repr__(self):
        if not self.head:
            return "[]"
        r = "["
        for i, node in enumerate(self):
            r += f"{node.data}, "
        return r[:-2] + ']'

    @property
    def tail(self):
        return self[-1]

    def append(self, item):
        if not self.head:
            self.head = Node(item)
        else:
            self.tail.next = Node(item)
        self.size += 1

    def prepend(self, item):
        if not self.head:
            self.head = Node(item)
        else:
            new_head = Node(item)
            new_head.next = self.head
            self.head = new_head
        self.size += 1

    def pop_first(self):
        if not self.head:
            return None
        node = self.head
        self.head = self.head.next
        self.size -= 1
        return node

    def pop_last(self):
        if not self.head:
            return None
        if self.head.next is None:
            return self.pop_head()

        new_tail = self[-2]
        tail = new_tail.next
        new_tail.next = None
        self.size -= 1
        return tail

    def pop_at(self, ind):
        if ind == 0:
            return self.pop_first()
        if ind == self.size - 1:
            return self.pop_last()

        prev_node = self[ind-1]
        node = prev_node.next
        prev_node.next = node.next
        return node

    def insert(self, ind, item):
        if ind == 0:
            self.prepend(item)
            return

        node = self[ind-1]
        nxt = node.next
        node.next = Node(item)
        node.next.next = nxt
        self.size += 1

    def reverse(self):
        if not self.head:
            return None

        prev = None
        current = self.head
        while current is not None:
            next = current.next
            current.next = prev
            prev = current
            current = next
        self.head = prev


def test():
    l = LinkedList()
    l.append(1)
    l.append(2)
    l.append(3)
    l.append(4)
    l.prepend(1)
    l.prepend(2)
    l.prepend(3)
    l.prepend(4)
    l.pop_first()
    l.pop_last()
    l.pop_at(0)
    l.pop_at(0)
    l.pop_at(0)

    print(l)
    l.reverse()
    l.insert(2, "hi")
    print(l)
    return l

l = test()
l
l[3]
