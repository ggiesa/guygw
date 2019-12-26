package main
import "fmt"


type BinaryHeap struct {
  data []int
  size int
}


// Percolate a newly inserted node up until it's less than or equal to both of its children
func (heap *BinaryHeap) percUp() {

  new_node_ind := heap.size - 1
  parent_node_ind := new_node_ind / 2

  for (heap.data[new_node_ind] < heap.data[parent_node_ind]) {
    heap.data[new_node_ind], heap.data[parent_node_ind] = heap.data[parent_node_ind], heap.data[new_node_ind]
    new_node_ind = parent_node_ind
    parent_node_ind = new_node_ind / 2
  }
}

// Percolate a given node down until it's less than or equal to its children
func (heap *BinaryHeap) percDown(node_ind int) {

  min_child_ind := heap.minChild(node_ind)
  for heap.data[node_ind] > heap.data[min_child_ind] {
      heap.data[min_child_ind], heap.data[node_ind] = heap.data[node_ind], heap.data[min_child_ind]
      node_ind = min_child_ind
      min_child_ind = heap.minChild(node_ind)
  }
}

// Return the index of the minimum node between right and left childeren of a given node
func (heap *BinaryHeap) minChild(node_ind int) int {
  left_child_ind := node_ind * 2
  right_child_ind := left_child_ind + 1

  if node_ind == 0 {
    left_child_ind += 1
    right_child_ind += 1
  }

  if left_child_ind >= heap.size {
    return node_ind
  }
  if heap.data[left_child_ind] < heap.data[right_child_ind] {
    return left_child_ind
  }
  return right_child_ind
}

// Insert a node at the bottom right of the tree and perc up until the tree is a heap
func (heap *BinaryHeap) Insert(val int) {
  heap.data = append(heap.data, val)
  heap.size += 1
  heap.percUp()
}

// Remove and return the root of the tree, replacing it with the bottom-right most node. Perc
// the new root down until the tree is a heap again
func (heap *BinaryHeap) PopMin() int {
  min_node := heap.data[0]
  heap.data[0] = heap.data[heap.size-1]
  heap.percDown(0)
  heap.data = heap.data[:heap.size-1]
  heap.size -= 1
  return min_node

}

// Create a new binary heap from a slice
func (heap *BinaryHeap) New(arr []int) {
  heap.data = arr

  i := heap.size - 1
  for i >= 0 {
    heap.percDown(i)
    i -= 1
  }
}


func main() {
  b := BinaryHeap{}
  b.Insert(2)
  b.Insert(3)
  b.Insert(1)
  b.Insert(4)
  b.Insert(40)
  b.Insert(4)
  b.Insert(3)
  b.Insert(0)


  fmt.Println(b.data)
  fmt.Println(b.PopMin())
  fmt.Println(b.data)

  t := []int{2,3,1,4,40,4,3,0}
  b.New(t)
  fmt.Println(b.data)

}
