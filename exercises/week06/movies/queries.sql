USE movies

GO

-- Задача №1
-- Напишете заявка, която извежда заглавие и година на всички филми, които са
-- по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
-- неизвестна, заглавието и годината на този филм също да се изведат.SELECT TITLE, YEAR, LENGTHFROM MOVIEWHERE (LENGTH > 120 OR LENGTH IS NULL) AND YEAR < 2000-- Задача №2-- Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
-- чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
-- подреден по име в намаляващ ред.

SELECT NAME, GENDER 
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE >= '1.1.1948'
ORDER BY NAME DESC

-- Задача №3
-- Напишете заявка, която извежда име на студио и брой на актьорите,
-- участвали във филми, които са създадени от това студио.SELECT STUDIONAME, COUNT(DISTINCT STARNAME) AS #ACTORSFROM MOVIEJOIN STARSIN ON MOVIETITLE = TITLEGROUP BY STUDIONAME-- Задача №4-- Напишете заявка, която за всеки актьор извежда име на актьора и броя на
-- филмите, в които актьорът е участвал.

SELECT NAME, COUNT(MOVIETITLE) AS #MOVIES
FROM MOVIESTAR
LEFT JOIN STARSIN ON NAME = STARNAME
GROUP BY NAME

-- Задача №5
-- Напишете заявка, която за всяко студио извежда име на студиото и заглавие
-- на филма, излязъл последно на екран за това студио.

SELECT STUDIONAME, TITLE, YEAR
FROM MOVIE AS M
WHERE TITLE IN (SELECT TITLE FROM MOVIE WHERE M.STUDIONAME = STUDIONAME AND YEAR >= ALL (SELECT YEAR FROM MOVIE WHERE M.STUDIONAME = STUDIONAME))
ORDER BY STUDIONAME DESC

-- Задача №6
-- Напишете заявка, която извежда името на най-младия актьор (мъж).

SELECT NAME 
FROM MOVIESTAR
WHERE GENDER = 'M'
	  AND 
	  BIRTHDATE >= ALL(SELECT BIRTHDATE 
					   FROM MOVIESTAR 
					   WHERE GENDER = 'M')

-- Задача №7
-- Напишете заявка, която извежда име на актьор и име на студио за тези
-- актьори, участвали в най-много филми на това студио.

SELECT STARNAME, STUDIONAME, COUNT(MOVIETITLE)
FROM STARSIN
JOIN MOVIE AS M ON TITLE = MOVIETITLE
GROUP BY STARNAME, STUDIONAME
HAVING COUNT(MOVIETITLE) >= ALL (SELECT COUNT(MOVIETITLE)
								 FROM STARSIN
								 JOIN MOVIE ON TITLE = MOVIETITLE
								 GROUP BY STARNAME, STUDIONAME
								 HAVING M.STUDIONAME = STUDIONAME)

-- Задача №8
-- Напишете заявка, която извежда заглавие и година на филма, и брой на
-- актьорите, участвали в този филм за тези филми с повече от двама актьори.

SELECT TITLE, YEAR, COUNT(STARNAME) AS #STARS
FROM MOVIE
JOIN STARSIN ON MOVIETITLE = TITLE
GROUP BY TITLE, YEAR
HAVING COUNT(STARNAME) > 2
