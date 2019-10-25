package main
import "fmt"

type Stack struct {
  data []interface{}
  size int
}

// Add an element to the end of the array
func (s *Stack) Push(item interface{}) {
  s.data = append(s.data, item)
  s.size += 1
}

// Remove the last element in the array and return it
func (s *Stack) Pop() interface{} {
  if s.size == 0 {return nil}

  item := s.data[s.size-1]
  s.data = s.data[:s.size-1]
  s.size -= 1
  return item
}

// Return the last element in the array; don't remove it
func (s *Stack) Peek() interface{} {
  if s.size == 0 {return nil}
  return s.data[s.size-1]
}

func main() {
  s := Stack{}
  s.Push(1)
  s.Push(2)
  s.Push(3)

  fmt.Println(s.data, "|", s.size)

  item := s.Pop()
  fmt.Println(item)
  fmt.Println(s.data, "|", s.size)
  item = s.Pop()
  fmt.Println(item)
  fmt.Println(s.data, "|", s.size)
}
