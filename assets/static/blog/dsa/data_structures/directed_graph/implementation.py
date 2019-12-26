

class Node:
    def __init__(self, key):
        self.key = key
        self.neighbors = set()

    def __repr__(self):
        ret = str(self.key)
        if self.neighbors:
            ret += ' -> {'
            for neighbor in self.neighbors:
                ret += f' {neighbor},'
            ret = ret[:-1] + ' }'
        return ret

    def add_neighbor(self, neighbor_key):
        self.neighbors.add(neighbor_key)


class Graph:
    def __init__(self):
        self.nodes = {}
        self.num_nodes = 0

    def __repr__(self):
        s = ""
        for node in self.nodes.values():
            s += " " + str(node) + ","
        return s[:-1]

    def __contains__(self, key):
        return key in self.nodes

    def __iter__(self):
        return iter(self.nodes.values())

    def __getitem__(self, key):
        return self.nodes[key]

    def add_node(self, key):
        self.nodes[key] = Node(key)
        self.num_nodes += 1
        return self.nodes[key]

    def get_node(self, key):
        return self.nodes.get(key)

    def add_edge(self, source_key, dest_key, weight=0):
        if source_key not in self.nodes:
            self.add_node(source_key)
        if dest_key not in self.nodes:
            self.add_node(dest_key)
        self.nodes[source_key].add_neighbor(dest_key)

    def find_paths(self, start_key, target_key):
        """Use depth first search to find all possible paths between two nodes"""

        stack = [(start_key, [start_key])]
        while stack:
            node_key, path = stack.pop()
            node = self.nodes[node_key]
            for nxt in node.neighbors - set(path):
                if nxt == target_key:
                    yield path + [nxt]
                else:
                    stack.append((nxt, path + [nxt]))

    def dfs(self, start_key):
        visited, stack = set(), [start_key]
        while stack:
            node_key = stack.pop()
            if node_key not in visited:
                visited.add(node_key)
                stack.extend(self.nodes[node_key].neighbors - visited)
        return visited


    def bfs(self):
        pass


def test():
    g = Graph()
    g.add_edge(1,2)
    g.add_edge(2,3)
    g.add_edge(3,4)
    g.add_edge(3,7)
    g.add_edge(4,5)
    g.add_edge(4,6)
    g.add_edge(4,7)

    return g
#
# g = test()
# for path in g.find_paths(1, 7):
#     print(path)
#
# g.dfs(1)


class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

def validate_bst(root):
    if not root:
        return True

    if root.left and root.left.val > root.val:
            return False

    if root.right and root.right.val < root.val:
            return False

    return validate_bst(root.left) and validate_bst(root.right)
