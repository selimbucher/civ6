import postgres from 'postgres';

const sql = postgres();

export async function load() {
    const players = await sql`
        SELECT id, name, active, achievement_points, streak
        FROM players
        WHERE active = true
        ORDER BY name
    `;
    return { players };
}