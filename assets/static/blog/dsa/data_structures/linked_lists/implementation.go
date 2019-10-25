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

func (l *LinkedList) Prepend(val interface{}) {
  head := l.head
  l.head = &Node{value: val, next: head}
  l.size += 1
}

func (l *LinkedList) Append(val interface{}) {
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

func (l *LinkedList) PopAt(ind int) interface{} {

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

func (l *LinkedList) Reverse() {
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

func (l *LinkedList) DisplayValues() {
  node := l.head
  for i := 0; i < l.size; i++ {
    fmt.Print(node.value, ", ")
    node = node.next
  }
  fmt.Println()
}



func main() {
  l := LinkedList{}
  l.Append("there")
  l.Prepend("hi")
  l.Append("small")
  l.Append("gerbil")
  l.PopAt(2)
  l.DisplayValues()

  l.Reverse()
  l.DisplayValues()

}
