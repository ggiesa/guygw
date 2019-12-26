
class Node:
    def __init__(self, key, val, left=None, right=None, parent=None):
        self.key = key
        self.val = val
        self.left = left
        self.right = right
        self.parent = parent

    @property
    def is_root(self):
        return not self.parent

    @property
    def is_leaf(self):
        return not (self.left or self.right)

    @property
    def is_left_child(self):
        return self == self.parent.left

    @property
    def is_right_child(self):
        return self == self.parent.right

    @property
    def has_any_childeren(self):
        return self.left or self.right

    @property
    def has_only_one_child(self):
        return self.has_any_childeren and not self.has_both_children

    @property
    def has_both_children(self):
        return self.left and self.right

    def replace_data(self, key, val, left, right):

        self.key = key
        self.val = val
        self.left = left
        self.right = right

        if left:
            left.parent = self
        if right:
            right.parent = self


class BTree:
    def __init__(self):
        self.root = None
        self.size = 0

    def __len__(self):
        return self.size

    def __setitem__(self, key, val):
        self.put(key, val)

    def __getitem__(self, key):
        return self.get(key)

    def __contains__(self, key):
        return self.get(key) is not None

    def __delitem__(self, key):
        self.delete(key)

    def _put(self, key, val, node):

        if not node:
            return Node(key, val)
        if key < node.key:
            if node.left:
                self._put(key, val, node.left)
            else:
                node.left = TreeNode(key, val, parent=node)
        elif key > node.key:
            if node.right:
                self._put(key, val, node.right)
            else:
                node.right = TreeNode(key, val, parent=node)
        else:
            node.val = val

    def put(self, key, val):
        if not self.root:
            self.root = TreeNode(key, val)
        else:
            self._put(key, val, self.root)
        self.size += 1

    def _get(self, key, node):
        if not node or node.key == key:
            return node
        if key < node.key:
            return self._get(key, node.left)
        return self._get(key, node.right)

    def get(self, key):
        return self._get(key, self.root)

    def delete(self, key):

        if self.size == 1 and self.root.key == key:
            self.root = None
            self.size -= 1
            return

        node_to_remove = self.get(key)
        if not node_to_remove:
            raise KeyError(f"Key {key} not found")

        self._remove_node(node_to_remove)
        self.size -= 1

    def _remove_node(self, node):

        # Node has no children
        if node.is_leaf:
            if node == node.parent.left:
                node.parent.left = None
            else:
                node.parent.right = None

        # Node only has one child
        elif node.has_only_one_child:
            if node.left:
                if node.is_left_child:
                    node.left.parent = node.parent
                    node.parent.left = node.left
                elif node.is_right_child:
                    node.left.parent = node.parent
                    node.parent.right = node.left
                else: # Node is the root node
                    node.replace_data(
                        node.left.key, node.left.val, node.left.left, node.left.right
                    )
            else:
                if node.is_left_child:
                    node.right.parent = node.parent
                    node.parent.left = node.right
                elif node.is_right_child:
                    node.right.parent = node.parent
                    node.parent.right = node.right
                else: # Node is the root node
                    node.replace_data(
                        node.right.key, node.right.val, node.right.left, node.right.right
                    )
        # Node has both children
        else:
