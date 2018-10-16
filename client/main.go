package main

import (
  "fmt"
  "net/http"
  "github.com/koding/tunnel"
)

func main() {
  // Setup the server to test that although no port has been
  // exposed we can reach this container from the other
  // container.
  http.HandleFunc("/", helloWorld)
  go http.ListenAndServe(":5000", nil)

  cfg := &tunnel.ClientConfig{
	Identifier: "123456",
	ServerAddr: "server:5000",
  }

  client, err := tunnel.NewClient(cfg)
  if err != nil {
	panic(err)
  }

  client.Start()
}

func helloWorld(w http.ResponseWriter, r *http.Request){
    fmt.Fprintf(w, "Hello World")
}
