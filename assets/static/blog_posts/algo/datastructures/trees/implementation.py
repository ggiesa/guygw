
class BTree:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None

    def insert_left(self, key):
        if self.left is None:
            self.left = BTree(key)
        else:
            t = BTree(key)
            t.left = self.left
            self.left = t

    def insert_right(self, key):
        if self.right is None:
            self.right = BTree(key)
        else:
            t = BTree(key)
            t.right = self.right
            self.right = t


def preorder_traverse(tree):
    if tree:
        yield tree.key
        yield from preorder_traverse(tree.left)
        yield from preorder_traverse(tree.right)

def postorder_traverse(tree):
    if tree:
        yield from postorder_traverse(tree.left)
        yield from postorder_traverse(tree.right)
        yield tree.key


t = BTreeg(0)
t.insert_left(1)
t.insert_left(2)
t.insert_left(3)
t.insert_left(4)
t.insert_left(5)
t.insert_left(6)
t.insert_left(7)
t.insert_right(8)
t.insert_right(9)
t.insert_right(10)
t.insert_right(11)
t.insert_right(12)
t.insert_right(13)
t.insert_right(14)

list(preorder_traverse(t))
list(postorder_traverse(t))
