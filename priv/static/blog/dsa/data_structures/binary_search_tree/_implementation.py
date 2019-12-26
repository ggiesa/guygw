
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

    def traverse(self, method='preorder'):
        method = method.lower()
        if method == 'preorder':
            yield from self._preorder_traverse(self)
        elif method == 'postorder':
            yield from self._postorder_traverse(self)
        elif method == 'inorder':
            yield from self._inorder_traverse(self)
        else:
            methods = ['preorder', 'postorder', 'inorder']
            raise ValueError(f"""
                Unrecognized traversal method. Options are {methods}. Provided: {method}.
            """)

    def _preorder_traverse(self, tree):
        if tree:
            yield tree.key
            yield from self._preorder_traverse(tree.left)
            yield from self._preorder_traverse(tree.right)

    def _postorder_traverse(self, tree):
        if tree:
            yield from self._postorder_traverse(tree.left)
            yield from self._postorder_traverse(tree.right)
            yield tree.key

    def _inorder_traverse(self, tree):
        if tree:
            yield from self._inorder_traverse(tree.left)
            yield tree.key
            yield from self._inorder_traverse(tree.right)



t = BTree(0)
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

# list(t.traverse('preorder'))
# list(t.traverse('postorder'))
list(t.traverse('inorder'))
