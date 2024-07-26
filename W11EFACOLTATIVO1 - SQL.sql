-- 1)VISUALIZZATE LE PRIME 10 RIGHE DELLA TABELLA ALBUM
SELECT 
    *
FROM
    album
LIMIT 10;

-- 2)TROVATE IL NUMERO TOTALE DI CANZONI DELLA TABELLA TRACKS
SELECT 
    COUNT(Name) AS SOMMA_TRACCE
FROM
    track;
-- 3)TROVATE I DIVERSI GENERI PRESENTI NELLA TABELLA GENERE
SELECT NAME AS GENERE
FROM GENRE;

-- 4)RECUPERATE IL NOME DI TUTTE LE TRACCE E DEL GENERE ASSOCIATO
SELECT 
    track.Name AS nome_traccia, genre.Name AS nome_genere
FROM
    TRACK
        JOIN
    genre ON track.GenreId = genre.GenreId;

-- 5)RECUPERATE IL NOME DI TUTTI GLI ARTISTI CHE HANNO ALMENO UN ALBUM NEL DATABASE. ESISTONO ARTISTI SENZA ALBUM NEL DATABASE?
SELECT 
    artist.ArtistId, artist.name
FROM
    artist
WHERE
    ArtistId   IN (SELECT 
            ArtistId
        FROM
            album);
		
-- 6)RECUPERATE IL NOME DI TUTTE LE TRACCE , DEL GENRE ASSOCIATO E DELLA TIPOLOGIA DI MEDIA.ESISTE UN MODO PER RECUPERARE IL NOME DELLA TIPOLOGIA DI MEDIA?
SELECT 
    track.Name, genre.Name, mediatype.Name
FROM
    track
        JOIN
    genre ON track.GenreId = genre.GenreId
        JOIN
    mediatype ON track.MediaTypeId = mediatype.MediaTypeId;
    
-- 7)ELENCATE I NOMI DI TUTTI GLI ARTISTI E DEI LORO ALBUM
SELECT 
    artist.Name,
    album.Title as nome_album
FROM
    artist
        JOIN
    album ON artist.ArtistId = album.ArtistId

