package main
import "fmt"

type Queue struct {
  data []interface{}
  size int
}

func (q *Queue) enqueue(val interface{}) {
  q.data = append(q.data, val)
  q.size += 1
}

func (q *Queue) dequeue() interface{} {
  if q.size == 0 {return nil}
  val := q.data[0]
  q.data = q.data[1:]
  q.size -= 1
  return val
}


func main() {
  q := Queue{}
  q.enqueue(1)
  q.enqueue(2)
  q.enqueue(3)

  fmt.Println(q.data, "|", q.size)
  val := q.dequeue()
  val = q.dequeue()
  val = q.dequeue()
  fmt.Println(val)
  fmt.Println(q.data, "|", q.size)
}
