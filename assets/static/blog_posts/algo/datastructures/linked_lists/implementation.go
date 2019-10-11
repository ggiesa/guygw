package main
import "fmt"

type Node struct {
  value interface{}
  next *Node
}

type LinkedList struct {
  head *Node
  size int
}

func (l *LinkedList) prepend(val interface{}) {
  head := l.head
  l.head = &Node{value: val, next: head}
  l.size += 1
}

func (l *LinkedList) append(val interface{}) {
  if l.size == 0 {
    l.head = &Node{value: val}
    l.size += 1
    return
  }

  node := l.head
  for i := 0; i < l.size-1; i++ {
    node = node.next
  }
  node.next = &Node{value: val}
  l.size += 1
}

func (l *LinkedList) pop_at(ind int) interface{} {

  if ind == 0 {
    val := l.head.value
    l.head = l.head.next
    l.size -= 1
    return val
  }

  prev := &Node{}
  node := l.head
  for i := 0; i < ind; i++ {
    prev = node
    node = node.next
  }

  val := node.value
  prev.next = node.next
  l.size -= 1
  return val
}

func (l *LinkedList) reverse() {
  prev := &Node{}
  next := &Node{}
  curr := l.head
  for i := 0; i < l.size; i++ {
    next = curr.next
    curr.next = prev
    prev = curr
    curr = next
  }
  l.head = prev
}

func (l *LinkedList) display_values() {
  node := l.head
  for i := 0; i < l.size; i++ {
    fmt.Print(node.value, ", ")
    node = node.next
  }
  fmt.Println()
}



func main() {
  l := LinkedList{}
  l.append("there")
  l.prepend("hi")
  l.append("small")
  l.append("gerbil")
  l.pop_at(2)
  l.display_values()

  l.reverse()
  l.display_values()

}
