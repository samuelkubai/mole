package main

import (
  "fmt"
  "net/http"
  "github.com/koding/tunnel"
  "os"
)

func main() {
  PORT := fmt.Sprintf(":%s", os.Getenv("PORT")) // ":5000"

  // Initialize the tunnel server
  cfg := &tunnel.ServerConfig{}
  server, _ := tunnel.NewServer(cfg)
  server.AddHost("tunnel.mole.test", "123456")

  fmt.Println(fmt.Sprintf("Starting the tunnel server on tunnel.mole.test%s", PORT))
  http.ListenAndServe(PORT, server)
}
