# Binary Heap

A binary heap is a heap data structure that takes the form of a binary tree. They are commonly used to implement [priority queues](https://en.wikipedia.org/wiki/Priority_queue), and are usually used as part of the [heapsort](https://en.wikipedia.org/wiki/Heapsort) sorting algorithm.

As a special case of a [binary tree](https://en.wikipedia.org/wiki/Binary_tree), binary heaps have two additional constraints:
- A binary heap is a complete binary tree, meaning that all levels of the tree are guaranteed to be completely filled except for the lowest level. If the last level is not complete, nodes are filled in from left to right.
- Depending on the sorting order, the key stored in each node is either less than or equal to, or greater than or equal to, the key of the parent node.

Common binary heap operation complexity:

Operation | Average | Worst Case
--- | :---: | :---:
Space | O(n) | O(n)
Search | O(n) |	O(n)
Insert | O(1) |	O(log n)
Delete | O(log n) |	O(log n)
Peek | O(1) |	O(1)
