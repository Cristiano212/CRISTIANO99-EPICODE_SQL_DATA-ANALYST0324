-- 1)RECUPERATE TUTTE LE TRACCE CHE ABBIANO COME GENERE POP O ROCK
SELECT 
    track.Name,
    genre.Name
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
    where genre.Name in( 'pop','rock');
    
    
-- 2)ELENCATE TUTTI GLI ARTISTI E/O GLI ALBUM CHE INIZIANO CON LA LETTERA A
SELECT 
    artist.Name, album.Title
FROM
    artist
        LEFT JOIN
    album ON artist.ArtistId = album.ArtistId
WHERE
    artist.name LIKE 'a%'
        AND album.Title LIKE 'a%';
        
-- )ELENCATE  TUTTE LE TRACCE CHE HANNO COME GENERE JAZZ O CHE DURANO MENO DI 3 MINUTI
SELECT 
    track.name, genre.Name,  track.Milliseconds
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
WHERE
    genre.Name = 'jazz'
        OR track.Milliseconds < 180000;
        
-- 4)RECUPERATE TUTTE LE TRACCE PIU LUNGHE DELLA DURATA MEDIA
SELECT 
    Name, Milliseconds
FROM
    track
WHERE
    Milliseconds > (SELECT 
            AVG(Milliseconds)
        FROM
            track);
            
-- 5)INDIVIDUATE I GENERI CHE HANNO TRACCE CON UNA DURATA MEDIA MAGGIORE DI 4 MINUTI
SELECT 
    genre.Name
FROM
    genre
        JOIN
    track ON genre.GenreId = track.GenreId
    group by genre.Name
    having avg(track.Milliseconds) >240000;
    
-- 6)individuate gli artisti che hanno rilasciato piu di un album
SELECT 
    artist.Name,
    count(album.ArtistId)
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId
GROUP BY artist.name
HAVING COUNT(album.ArtistId) > 1;

-- 7)TROVATE LA TRACCIA PIU LUNGA IN OGNI ALBUM
SELECT 
    a.Title AS nome_album,
    a.AlbumId,
    t.Name AS titolo_traccia,
    t.Milliseconds
FROM 
    track t
JOIN 
    album a ON t.AlbumId = a.AlbumId
WHERE 
    t.Milliseconds = (
        SELECT MAX(t2.Milliseconds)
        FROM track t2
        WHERE t2.AlbumId = t.AlbumId
    );

-- 8)INDIVIDUATE LA DURATA MEDIA DELLE TRACCE PER OGNI ALBUM
SELECT 
    avg(t.Milliseconds),
    a.Title
FROM
    track t
        JOIN
    album a ON t.AlbumId = a.AlbumId
    group by a.AlbumId;
    
-- 9)INDIVIDUATE GLI ALBUM CHE HANNO PIU DI 20 TRACCE E MOSTRATE IL NUMERO DI TRACCE IN ESSO CONTENUTE
   SELECT 
    album.Title AS titolo_album,
    COUNT(track.TrackId) AS numero_tracce
FROM
    album
        JOIN
    track ON album.AlbumId = track.AlbumId
GROUP BY album.AlbumId 
HAVING COUNT(track.TrackId) > 20


    


