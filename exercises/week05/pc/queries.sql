USE pc

GO

-- Задача №1
-- Напишете заявка, която извежда средната честота на персоналните компютри.

SELECT CONVERT(DECIMAL(19, 2), AVG(speed)) AS avg_speed 
FROM pc

-- Задача №2
-- Напишете заявка, която извежда средния размер на екраните на лаптопите за
-- всеки производител.

SELECT maker, AVG(screen) AS avg_screen 
FROM laptop
JOIN product ON laptop.model = product.model
GROUP BY maker

-- Задача №3
-- Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT CONVERT(DECIMAL(19, 2), AVG(speed)) AS avg_price
FROM laptop
WHERE price > 1000

-- Задача №4
-- Напишете заявка, която извежда средната цена на персоналните компютри,
-- произведени от производител 'A'

SELECT maker, CONVERT(DECIMAL(19, 2), AVG(price)) AS avg_price 
FROM pc
JOIN product ON product.model = pc.model
GROUP BY maker
HAVING maker = 'A'

-- Задача №5
-- Напишете заявка, която извежда средната цена на персоналните компютри и
-- лаптопите за производител 'B'

-- Начин №1:

SELECT AVG(price)
FROM (SELECT maker, price
      FROM product
      JOIN pc ON pc.model = product.model
	  
      UNION ALL
	  
      SELECT maker, price 
      FROM product
      JOIN laptop ON laptop.model = product.model) AS all_prices
GROUP BY maker
HAVING maker = 'B'

-- Начин №2:

SELECT (SUM(pc.price) + SUM(laptop.price)) / COUNT(*) 
FROM product
LEFT JOIN pc ON pc.model = product.model
LEFT JOIN laptop ON laptop.model = product.model
WHERE maker = 'B'

-- Задача №6
-- Напишете заявка, която извежда средната цена на персоналните компютри
-- според различните им честоти.

SELECT speed, AVG(price) AS avg_price
FROM pc
GROUP BY speed

-- Задача №7
-- Напишете заявка, която извежда производителите, които са произвели поне 3
-- различни персонални компютъра (с различен код).
	 
SELECT maker, COUNT(code) AS #PC 
FROM product
JOIN pc ON pc.model = product.model
GROUP BY maker
HAVING COUNT(code) >= 3

-- Задача №8
-- Напишете заявка, която извежда производителите с най-висока цена на
-- персонален компютър.
	 
SELECT maker, MAX(price) AS max_price 
FROM product
JOIN pc ON pc.model = product.model
GROUP BY maker
HAVING MAX(price) >= ALL(SELECT price FROM pc)

-- Задача №9
-- Напишете заявка, която извежда средната цена на персоналните компютри за
-- всяка честота по-голяма от 800.
	 
SELECT speed, AVG(price) AS avg_price 
FROM pc
GROUP BY speed
HAVING speed > 800

-- Задача №10
-- Напишете заявка, която извежда средния размер на диска на тези персонални
-- компютри, произведени от производители, които произвеждат и принтери.
-- Резултатът да се изведе за всеки отделен производител.

SELECT maker, CONVERT(DECIMAL(19, 2), AVG(hd)) AS avg_hdd FROM product
LEFT JOIN pc ON pc.model = product.model
LEFT JOIN printer ON printer.model = product.model
GROUP BY maker
HAVING COUNT(printer.code) > 0 AND COUNT(pc.code) > 0
