package model

type Player struct {
	ID                  int     `json:"id"`
	Name                string  `json:"name"`
	Rating              float64 `json:"rating"`
	RD                  float64 `json:"rd"`
	Volatility          float64 `json:"volatility"`
	Active              bool    `json:"active"`
	AchievementPoints   int     `json:"achievement_points"`
	Streak              int     `json:"streak"`
}