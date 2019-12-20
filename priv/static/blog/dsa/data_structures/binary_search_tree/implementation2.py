
class Node:
    def __init__(self, key, val, size):
        self.key = key
        self.val = val
        self.size = size
        self.left = None
        self.right = None


class BSTree:
    def __init__(self):
        self.root = None

    def __len__(self):
        return self.root.size

    def __getitem__(self, key):
        return self.get(key)

    def __setitem__(self, key, val):
        self.put(key, val)

    def __contains__(self, key):
        return self.get(key) is not None

    @property
    def is_empty(self):
        return self.root is None

    def _size(self, node):
        if node:
            return node.size
        return 0

    def get(self, key):
        return self._get(key, self.root)

    def _get(self, key, node):
        if not node:
            return node

        if key < node.key:
            return self._get(key, node.left)
        if key > node.key:
            return self._get(key, node.right)
        return node.val

    def put(self, key, val):
        self.root = self._put(key, val, self.root)

    def _put(self, key, val, node):
        if not node:
            return Node(key, val, 1)

        if key < node.key:
            node.left = self._put(key, val, node.left)
        elif key > node.key:
            node.right = self._put(key, val, node.right)
        else:
            node.val = val

        node.size = self._size(node.left) + self._size(node.right) + 1
        return node

    @property
    def min_key(self):
        if self.is_empty:
            return None
        return self._min_node(self.root).key

    def _min_node(self, node):
        if not node.left:
            return node
        return self._min_node(node.left)

    def delete_min_node(self):
        if self.is_empty:
            raise AttributeError("Tree is empty")
        return self._delete_min_node(self.root)

    def _delete_min_node(self, node):
        if not node.left:
            return node.right
        node.left = self._delete_min_node(node.left)
        node.size = self._size(node.left) + self._size(node.right) + 1
        return node

    def delete(self, key):
        self.root = self._delete(key, self.root)

    def _delete(self, key, node):

        # Key does not exist in the tree
        if not node:
            return node

        if key < node.key:
            node.left = self._delete(key, node.left)
        elif key > node.key:
            node.right = self._delete(key, node.right)
        else:
            if not node.left:
                return node.right
            if not node.right:
                return node.left

            t = node
            node = self._min_node(t.right)
            node.right = self._delete_min_node(t.right)
            node.left = t.left

        node.size = self._size(node.left) + self._size(node.right) + 1
        return node


def test():
    t = BSTree()

    t.put(2, 'hi')
    t.put(1, 'there')
    t.put(3, 'world')

    assert t.get(2) == 'hi'
    assert t.get(1) == 'there'
    assert t.get(3) == 'world'
    assert t.root.size == 3
    assert t.root.left.size == 1
    assert t.root.right.size == 1

    t.put(4, 'gozirra')
    assert len(t) == 4
    assert t.min_key == 1
    t.delete(1)
    assert len(t) == 3
    assert t.min_key == 2
