package api

import (
	"encoding/json"
	"net/http"
	"log"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/selimbucher/civ6.ch/internal/db"
)

func HandlePlayers(pool *pgxpool.Pool) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		players, err := db.GetPlayers(r.Context(), pool)
		if err != nil {
			log.Printf("GetPlayers error: %v", err)
			http.Error(w, "internal server error", http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(players)
	}
}