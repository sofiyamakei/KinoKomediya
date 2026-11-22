
from flask import Flask, render_template, jsonify
import pyodbc

app = Flask(__name__)


def get_connection():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 18 for SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"
        "DATABASE=KinoKomediya;"
        "Trusted_Connection=yes;"
        "TrustServerCertificate=yes;"
    )

@app.route("/")
def home():
    try:
        conn = get_connection()

        try:
            cursor = conn.cursor()

            cursor.execute("""
                SELECT
                    f.Title,
                    f.ReleaseYear,
                    f.Rating,
                    c.CountryName
                FROM Films AS f
                LEFT JOIN Countries AS c
                    ON f.CountryID = c.CountryID
                ORDER BY f.Title
            """)

            films = []

            for row in cursor.fetchall():
                films.append({
                    "title": row[0],
                    "year": row[1],
                    "rating": float(row[2]) if row[2] is not None else None,
                    "country": row[3]
                })

            return render_template("index.html", films=films)

        finally:
            conn.close()

    except Exception as e:
        return f"Ошибка: {e}", 500

@app.route("/graph")
def graph():
    return render_template("graph.html")

@app.route("/api/graph")
def graph_data():
    try:
        conn = get_connection()

        try:
            cursor = conn.cursor()
            nodes = []
            edges = []

            cursor.execute("""
                SELECT
                    f.FilmID,
                    f.Title,
                    f.ReleaseYear,
                    f.Rating,
                    f.Description,
                    c.CountryName
                FROM Films AS f
                LEFT JOIN Countries AS c
                    ON f.CountryID = c.CountryID
            """)

            for film_id, title, year, rating, description, country in cursor.fetchall():
                nodes.append({
                    "data": {
                        "id": f"film_{film_id}",
                        "label": title,
                        "type": "film",
                        "year": year,
                        "rating": float(rating) if rating is not None else None,
                        "description": description,
                        "country": country
                    }
                })

            cursor.execute("""
                SELECT GenreID, GenreName
                FROM Genres
            """)

            for genre_id, name in cursor.fetchall():
                nodes.append({
                    "data": {
                        "id": f"genre_{genre_id}",
                        "label": name,
                        "type": "genre"
                    }
                })

            cursor.execute("""
                SELECT PersonID, FullName, PersonType, BirthYear
                FROM People
            """)

            for person_id, name, person_type, birth_year in cursor.fetchall():
                nodes.append({
                    "data": {
                        "id": f"person_{person_id}",
                        "label": name,
                        "type": "person",
                        "personType": person_type,
                        "birthYear": birth_year
                    }
                })

            cursor.execute("""
                SELECT FilmID, GenreID
                FROM FilmGenres
            """)

            for film_id, genre_id in cursor.fetchall():
                edges.append({
                    "data": {
                        "source": f"film_{film_id}",
                        "target": f"genre_{genre_id}",
                        "relation": "Жанр"
                    }
                })

            cursor.execute("""
                SELECT FilmID, PersonID, RoleName, CharacterName
                FROM FilmPeople
            """)

            for film_id, person_id, role_name, character_name in cursor.fetchall():
                edges.append({
                    "data": {
                        "source": f"film_{film_id}",
                        "target": f"person_{person_id}",
                        "relation": role_name,
                        "character": character_name
                    }
                })

            cursor.execute("""
                SELECT
                    FilmID1,
                    FilmID2,
                    RelationType,
                    Description
                FROM FilmRelations
            """)

            for film_id1, film_id2, relation_type, description in cursor.fetchall():
                edges.append({
                    "data": {
                        "source": f"film_{film_id1}",
                        "target": f"film_{film_id2}",
                        "relation": relation_type,
                        "description": description
                    }
                })

            return jsonify({
                "nodes": nodes,
                "edges": edges
            })

        finally:
            conn.close()

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/recommendations/<int:film_id>")
def recommendations(film_id):
    try:
        conn = get_connection()

        try:
            cursor = conn.cursor()

            cursor.execute(
                "SELECT FilmID FROM Films WHERE FilmID = ?",
                film_id
            )

            if cursor.fetchone() is None:
                return jsonify({
                    "error": "Фильм не найден"
                }), 404

            cursor.execute("""
                SELECT
                    fg2.FilmID,
                    g.GenreName
                FROM FilmGenres fg1
                JOIN FilmGenres fg2
                    ON fg1.GenreID = fg2.GenreID
                JOIN Genres g
                    ON g.GenreID = fg1.GenreID
                WHERE fg1.FilmID = ?
                  AND fg2.FilmID <> ?
            """, film_id, film_id)

            scores = {}

            def add_score(other_id, points, reason):
                if other_id not in scores:
                    scores[other_id] = {
                        "score": 0,
                        "reasons": set()
                    }

                scores[other_id]["score"] += points
                scores[other_id]["reasons"].add(reason)

            for other_id, genre in cursor.fetchall():
                add_score(
                    other_id,
                    2,
                    f"Общий жанр: {genre}"
                )

            cursor.execute("""
                SELECT
                    fp2.FilmID,
                    p.FullName
                FROM FilmPeople fp1
                JOIN FilmPeople fp2
                    ON fp1.PersonID = fp2.PersonID
                JOIN People p
                    ON p.PersonID = fp1.PersonID
                WHERE fp1.FilmID = ?
                  AND fp2.FilmID <> ?
            """, film_id, film_id)

            for other_id, person in cursor.fetchall():
                add_score(
                    other_id,
                    3,
                    f"Общий участник: {person}"
                )

            cursor.execute("""
                SELECT
                    CASE
                        WHEN FilmID1 = ? THEN FilmID2
                        ELSE FilmID1
                    END AS OtherFilmID,
                    RelationType
                FROM FilmRelations
                WHERE FilmID1 = ? OR FilmID2 = ?
            """, film_id, film_id, film_id)

            for other_id, relation in cursor.fetchall():
                add_score(
                    other_id,
                    5,
                    f"Связь между фильмами: {relation}"
                )

            results = []

            for other_id, item in scores.items():
                cursor.execute("""
                    SELECT Title, ReleaseYear, Rating
                    FROM Films
                    WHERE FilmID = ?
                """, other_id)

                row = cursor.fetchone()

                if row:
                    results.append({
                        "film_id": other_id,
                        "title": row[0],
                        "year": row[1],
                        "rating": float(row[2]) if row[2] is not None else None,
                        "score": item["score"],
                        "reasons": sorted(item["reasons"])
                    })

            results.sort(
                key=lambda x: (
                    -x["score"],
                    -(x["rating"] if x["rating"] is not None else -1),
                    x["title"]
                )
            )

            return jsonify({
                "film_id": film_id,
                "recommendations": results[:5]
            })

        finally:
            conn.close()

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True)
