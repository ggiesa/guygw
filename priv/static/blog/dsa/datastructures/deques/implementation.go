package main
import "fmt"

type Deque struct {
  data []interface{}
  size int
}

func (d *Deque) add_front(item interface{}) {
  d.data = append(d.data, item)
  d.size += 1
}

func (d *Deque) add_rear(item interface{}) {
  s := make([]interface{}, 1)
  s[0] = item
  d.data = append(s, d.data...)
  d.size += 1
}

func (d *Deque) remove_front() interface{} {
  if d.size == 0 {return nil}
  val := d.data[d.size-1]
  d.data = d.data[:d.size-1]
  d.size -= 1
  return val
}

func (d *Deque) remove_rear() interface{} {
  if d.size == 0 {return nil}
  val := d.data[0]
  d.data = d.data[1:]
  d.size -= 1
  return val
}

func main() {
  d := Deque{}
  d.add_front(1)
  d.add_front(2)
  d.add_front(3)
  fmt.Println(d)
  d.add_rear(-1)
  d.add_rear(-2)
  d.add_rear(-3)
  fmt.Println(d)
  d.remove_front()
  d.remove_rear()
  fmt.Println(d)
}
