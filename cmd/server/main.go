package main

import (
	"context"
	"log"
	"net/http"

	"github.com/selimbucher/civ6.ch/internal/api"
	"github.com/selimbucher/civ6.ch/internal/db"
)

func main() {
	ctx := context.Background()

	pool, err := db.Connect(ctx)
	if err != nil {
		log.Fatal(err)
	}
	defer pool.Close()

	mux := http.NewServeMux()
	mux.HandleFunc("GET /api/players", api.HandlePlayers(pool))

	log.Println("listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", mux))
}