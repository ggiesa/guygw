// A simple and contrived example of a dynamic array in Go. This basically does exactly what a slice does, just worse.

package main
import "fmt"

type DynamicArray struct {
  data []interface{}
  length int
  capacity int
}

func (a *DynamicArray) append(val interface{}) {
  if a.length == 0 {
    a.resize(1)
  } else if (a.length == a.capacity) {
    a.resize(a.capacity * 2)
  }

  // Point the Slice to a larger portion of the underlying array so that we can append a single element
  a.data = a.data[:a.length+1]
  a.data[a.length] = val
  a.length ++

}

func (a *DynamicArray) resize(new_capacity int) {
  var temp []interface{}
  if a.length == 0 {
    temp = make([]interface{}, 1, 1)
  } else {
    temp = make([]interface{}, a.length, new_capacity)
  }

  // Copy existing data over to new slice
  for i := 0; i < a.length; i++ {
    temp[i] = a.data[i]
  }
  a.data = temp
  a.capacity = new_capacity
}

func (a *DynamicArray) get(index int) interface{} {
  if index >= a.length || index < 0 {
    panic("Invalid index")
  }
  return a.data[index]
}

func main() {
  a := DynamicArray{}
  for i := 0; i < 10; i++ {
    a.append(i)
    fmt.Println("Length:", a.length, "|", "Capacity:", a.capacity)
  }
  fmt.Println(a)
}
