# Stacks
A stack is a last-in-first-out data structure. As an analogy, picture a nested stack of bowls. It's natural to place a bowl on the top of the stack, and likewise remove a bowl from the top of the stack. Stacks handle data in the same way. Removing an element from a stack always removes the last element that you put in.

## Implementation
Implementing a stack is simple in each programming language I've chosen. The only major difference between the three is the choice between performing push and pop operations on the start of list of the end. Because Elixir implements its list data structure as a linked list, it's much faster to prepend data than append (O(1) vs. O(n)), whereas in Go and Python, appending is faster.  
