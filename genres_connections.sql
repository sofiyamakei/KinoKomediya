
USE KinoKomediya;

INSERT INTO FilmGenres (FilmID, GenreID)
SELECT f.FilmID, g.GenreID
FROM Films AS f
CROSS JOIN Genres AS g
WHERE g.GenreName = N'Романтическая комедия'
  AND f.Title IN (
      N'Предложение',
      N'Отпуск по обмену',
      N'Амели'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM FilmGenres AS fg
      WHERE fg.FilmID = f.FilmID
        AND fg.GenreID = g.GenreID
  );

INSERT INTO FilmGenres (FilmID, GenreID)
SELECT f.FilmID, g.GenreID
FROM Films AS f
CROSS JOIN Genres AS g
WHERE g.GenreName = N'Чёрная комедия'
  AND f.Title IN (
      N'Большой Лебовски',
      N'Отель «Гранд Будапешт»'
  )
  AND NOT EXISTS (
      SELECT 1
      FROM FilmGenres AS fg
      WHERE fg.FilmID = f.FilmID
        AND fg.GenreID = g.GenreID
  );

SELECT
    g.GenreName,
    COUNT(fg.FilmID) AS FilmCount
FROM Genres AS g
LEFT JOIN FilmGenres AS fg
    ON g.GenreID = fg.GenreID
GROUP BY g.GenreID, g.GenreName
ORDER BY g.GenreName;
