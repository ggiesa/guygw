package main
import "fmt"

type Queue struct {
  data []interface{}
  size int
}

func (q *Queue) Enqueue(val interface{}) {
  q.data = append(q.data, val)
  q.size += 1
}

func (q *Queue) Dequeue() interface{} {
  if q.size == 0 {return nil}
  val := q.data[0]
  q.data = q.data[1:]
  q.size -= 1
  return val
}


func main() {
  q := Queue{}
  q.Enqueue(1)
  q.Enqueue(2)
  q.Enqueue(3)

  fmt.Println(q.data, "|", q.size)
  val := q.Dequeue()
  val = q.Dequeue()
  val = q.Dequeue()
  fmt.Println(val)
  fmt.Println(q.data, "|", q.size)
}
