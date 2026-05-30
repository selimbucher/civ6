package db

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/selimbucher/civ6.ch/internal/model"
)

func GetPlayers(ctx context.Context, pool *pgxpool.Pool) ([]model.Player, error) {
	rows, err := pool.Query(ctx, `
		SELECT id, name, rating, rd, colatility, active, achievement_points, streak
		FROM players
		ORDER BY rating DESC
	`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var players []model.Player
	for rows.Next() {
		var p model.Player
		err := rows.Scan(&p.ID, &p.Name, &p.Rating, &p.RD, &p.Volatility, &p.Active, &p.AchievementPoints, &p.Streak)
		if err != nil {
			return nil, err
		}
		players = append(players, p)
	}
	return players, rows.Err()
}