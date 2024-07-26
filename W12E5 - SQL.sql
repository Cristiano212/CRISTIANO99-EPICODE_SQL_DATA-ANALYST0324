-- 1)Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.
SELECT 
    genre.name AS nome_genere, COUNT(track.name) AS nome_tracce
FROM
    genre
        INNER JOIN
    track ON genre.GenreId = track.GenreId
GROUP BY genre.name
HAVING COUNT(track.name) >= 10
ORDER BY nome_tracce DESC;

-- 2)Trovate le tre canzoni piu costose.
SELECT
    Name,
    UnitPrice
FROM
    track
ORDER BY UnitPrice DESC;

-- 3)Elencate gli artisti che hanno canzoni piu lunghe di 6 minuti
SELECT DISTINCT
art.Name
FROM 
    track AS tk
    JOIN album AS alb ON alb.AlbumId = tk.AlbumId
    JOIN artist AS art ON art.ArtistId = alb.ArtistId
    WHERE tk.Milliseconds > 360000;

-- 4)Individuate la durata media delle tracce per ogni genere
SELECT 
    genre.Name, AVG(track.Milliseconds)
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
GROUP BY genre.Name;

-- 5)Elencate tutte le canzoni con la parola "Love" nel titolo, ordinandole alfabeticamente prima per genere e poi per nome
SELECT 
    track.Name as nome_traccia, genre.Name as nome_genere
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
WHERE
    track.name LIKE '%Love%'
ORDER BY genre.Name ASC , track.Name ASC;

-- 6)Trovate il costo medio per ogni tipologia di media
SELECT
	mediatype.MediaTypeId,
    AVG(track.UnitPrice)
FROM
    track
        JOIN
    mediatype ON track.MediaTypeId = mediatype.MediaTypeId
GROUP BY mediatype.MediaTypeId;

-- 7)Individuate il genere con piu tracce

SELECT 
    genre.name AS genere, COUNT(track.TrackId) AS n_tracce
FROM
    genre
        JOIN
    track ON genre.GenreId = track.GenreId
GROUP BY genere
ORDER BY n_tracce DESC
LIMIT 1;

-- 8)Trovate gli artisti che hanno lo stesso numero di album dei rolling stones
SELECT 
    artist.Name,
    COUNT(*) AS numero_album
FROM
    album
        JOIN
    artist ON album.ArtistId = artist.ArtistId
WHERE
    artist.Name LIKE '%rolling stones%'
    group by artist.Name;
    
    
    SELECT 
    COUNT(album.AlbumId) AS numero_album, artist.Name 
FROM
    album
        JOIN
    artist ON album.ArtistId = artist.ArtistId
GROUP BY artist.name
HAVING numero_album = 3;
    
-- 9)Trovate l’artista con l’album più costoso.
    SELECT 
    SUM(track.UnitPrice) AS prezzo_album, artist.Name,album.AlbumId
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId
        JOIN
    track ON album.AlbumId = track.AlbumId
GROUP BY album.AlbumId
ORDER BY prezzo_album DESC;
-- LIMIT 1;
/* Esercizio 7

Individuate il genere con più tracce. */

SELECT G.NAME AS GENRE_NAME
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
HAVING COUNT(DISTINCT T.NAME)=(SELECT MAX(NUM_TRACK)
                    FROM(SELECT G.NAME AS GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
                            FROM TRACK T
                            LEFT JOIN GENRE G ON T.GENREID=G.GENREID
                            GROUP BY G.NAME) A );



/* Esercizio 8

Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.*/



SELECT AR.NAME ARTISTA, COUNT(AL.TITLE) AS NUM_ALBUM
FROM ALBUM AL 
LEFT JOIN ARTIST  AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME
HAVING NUM_ALBUM=(    SELECT COUNT(AL.TITLE) AS NUM_ALBUM
                    FROM ALBUM AL 
                    LEFT JOIN ARTIST  AR  ON AL.ARTISTID=AR.ARTISTID
                    WHERE AR.NAME = 'The Rolling Stones') ;


/* Esercizio 9

Trovate l’artista con l’album più costoso. */

SELECT AR.NAME ARTIST, AL.TITLE ALBUM -- , SUM(T.UNITPRICE) AS ALBUM_PRICE
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE
HAVING SUM(T.UNITPRICE)=(SELECT MAX(ALBUM_PRICE)
                            FROM(SELECT AR.NAME ARTIST, AL.TITLE ALBUM, SUM(T.UNITPRICE) AS ALBUM_PRICE
                            FROM TRACK T
                            LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
                            LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
                            GROUP BY AR.NAME, AL.TITLE)A);





