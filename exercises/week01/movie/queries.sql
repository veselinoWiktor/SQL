USE movies

GO

-- Задача №1
-- Напишете заявка, която извежда имената на актрисите, които са също и
-- продуценти с нетни активи над 10 милиона.

SELECT NAME 
FROM MOVIEEXEC
WHERE NETWORTH > 10000000
      AND
      NAME IN (SELECT NAME 
	       FROM MOVIESTAR
	       WHERE Gender = 'F')

-- Задача №2
-- Напишете заявка, която извежда имената на тези актьори (мъже и жени),
-- които не са продуценти.

SELECT NAME 
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT NAME FROM MOVIEEXEC)

-- Задача №3
-- Напишете заявка, която извежда имената на всички филми с дължина,
-- по-голяма от дължината на филма 'Star Wars'

SELECT TITLE 
FROM MOVIE
WHERE LENGTH > (SELECT LENGTH
		FROM MOVIE
		WHERE TITLE = 'Star Wars')

-- Задача №4
-- Напишете заявка, която извежда имената на продуцентите и имената на
-- филмите за всички филми, които са продуцирани от продуценти с нетни
-- активи по-големи от тези на 'Merv Griffin'

-- Начин №1:

SELECT TITLE, (SELECT NAME FROM MOVIEEXEC WHERE PRODUCERC# = CERT#) AS NAME
FROM MOVIE
WHERE PRODUCERC# IN (SELECT CERT#
		     FROM MOVIEEXEC
		     WHERE NETWORTH > (SELECT NETWORTH 
				       FROM MOVIEEXEC 
				       WHERE NAME = 'Merv Griffin'))

-- Начин №2: 

SELECT TITLE, NAME 
FROM MOVIE
JOIN MOVIEEXEC ON PRODUCERC# = CERT#
WHERE NETWORTH > (SELECT NETWORTH
		  FROM MOVIEEXEC
		  WHERE NAME = 'Merv Griffin')
