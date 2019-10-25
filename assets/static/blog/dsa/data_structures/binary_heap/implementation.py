
class BinaryHeap:
    def __init__(self):
        self._heap = [0]
        self.size = 0

    def __repr__(self):
        return str(self._heap)

    def _perc_up(self):
        """Percolate a newly inserted node at the bottom of the tree upwards until the node is
        less than or equal to both of its children
        """

        # Start with the bottom-right node
        node_ind = self.size
        parent_ind = node_ind // 2

        while parent_ind > 0:
            # If the parent node is less than the newly inserted node, swap them and continue.
            parent_ind = node_ind // 2
            if self._heap[node_ind] < self._heap[parent_ind]:
                self._heap[parent_ind], self._heap[node_ind] = self._heap[node_ind], self._heap[parent_ind]
            node_ind = parent_ind

    def _perc_down(self, node_ind):
        """Percolate a given node down until it's less than or equal to both of its children"""

        # If there is no left child node, we're at the bottom of the tree and there's nothing to do
        while (node_ind * 2) <= self.size:

            # If one of the childeren nodes is less than the given node, swap them and continue
            min_child_ind = self._min_child(node_ind)
            if self._heap[node_ind] > self._heap[min_child_ind]:
                self._heap[node_ind], self._heap[min_child_ind] = self._heap[min_child_ind], self._heap[node_ind]
            node_ind = min_child_ind



    def _min_child(self, node_ind):
        """Return the index of the minimum child node for a given node index"""
        left_node_ind = node_ind * 2
        right_node_ind = left_node_ind + 1

        if right_node_ind > self.size:
            return left_node_ind

        if self._heap[left_node_ind] < self._heap[right_node_ind]:
            return left_node_ind
        return right_node_ind

    def insert(self, val):
        """Insert a new node at the bottom-right of the tree, and then percolate the new node up if needed"""
        self._heap.append(val)
        self.size += 1
        self._perc_up()

    def pop_min(self):
        min_node = self._heap[1]
        self._heap[1] = self._heap[self.size]
        self.size -= 1
        self._heap.pop()
        self._perc_down(1)
        return min_node

    def build_heap(self, list):
        self.size = len(list)
        node_ind = self.size // 2
        self._heap = [0] + list
        while node_ind > 0:
            self._perc_down(node_ind)
            node_ind -= 1



inp = [1,10,5,6,11,22,3,50,1,2,51]

a = BinaryHeap()
a.build_heap(inp)

b = BinaryHeap()
for val in inp:
    b.insert(val)

assert a._heap == b._heap
