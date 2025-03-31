USE ships

GO

-- Задача №1
-- Напишете заявка, която извежда броя на класовете бойни кораби

SELECT COUNT(CLASS) AS #CLASS 
FROM CLASSES
WHERE TYPE = 'bb'

-- Задача №2
-- Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.

SELECT CLASS, AVG(NUMGUNS) AS avg_numguns 
FROM CLASSES
WHERE TYPE = 'bb'
GROUP BY CLASS

-- Задача №3
-- Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(NUMGUNS) AS avg_numguns
FROM SHIPS
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE TYPE = 'bb'

-- Задача №4
-- Напишете заявка, която извежда за всеки клас първата и последната година, в
-- която кораб от съответния клас е пуснат на вода.
SELECT CLASSES.CLASS, MIN(LAUNCHED) AS first_year, MAX(LAUNCHED) AS last_year
FROM CLASSES
JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS
GROUP BY CLASSES.CLASS

-- Задача №5
-- Напишете заявка, която извежда броя на корабите, потънали в битка според
-- класа.

SELECT CLASS, COUNT(NAME) AS #SUNK
FROM SHIPS
JOIN OUTCOMES ON NAME = SHIP
WHERE RESULT = 'sunk'
GROUP BY CLASS

-- Задача №6
-- Напишете заявка, която извежда броя на корабите, потънали в битка според
-- класа, за тези класове с повече от 2 кораба.

-- Начин №1:

SELECT CLASS, COUNT(RESULT) AS #SUNK
FROM SHIPS
LEFT JOIN OUTCOMES ON NAME = SHIP
WHERE RESULT = 'sunk' OR RESULT IS NULL
GROUP BY CLASS
HAVING COUNT(RESULT) > 0

-- Начин №2:

SELECT CLASS, COUNT(RESULT) AS #SUNK
FROM SHIPS
LEFT JOIN OUTCOMES ON NAME = SHIP
WHERE RESULT = 'sunk' AND CLASS IN (SELECT CLASS FROM SHIPS GROUP BY CLASS HAVING COUNT(NAME) > 2)
GROUP BY CLASS

-- Задача №7
-- Напишете заявка, която извежда средния калибър на оръдията на корабите за
-- всяка страна.

SELECT COUNTRY, CONVERT(DECIMAL(19, 2), AVG(Bore)) AS avg_bore
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY COUNTRY