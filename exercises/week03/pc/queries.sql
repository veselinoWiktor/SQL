USE pc

GO

-- Задача №1
-- Напишете заявка, която извежда производителите на персонални
-- компютри с честота над 500.

SELECT maker, model 
FROM product
WHERE model IN (SELECT model 
		FROM pc
		WHERE speed > 500)

-- Задача №2
-- Напишете заявка, която извежда код, модел и цена на принтерите с 
-- най-висока цена.

SELECT code, model, price
FROM printer
WHERE price >= ALL (SELECT price FROM printer)

-- Задача №3
-- Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
-- честотата на всички персонални компютри.

SELECT *
FROM laptop
WHERE speed < ALL (SELECT speed FROM pc)

-- Задача №4
-- Напишете заявка, която извежда модела и цената на продукта (PC,
-- лаптоп или принтер) с най-висока цена.

SELECT TOP 1 * 
FROM (SELECT model, price
      FROM pc
  
      UNION
  
      SELECT model, price
      FROM laptop
  
      UNION 
  
      SELECT model, price
      FROM printer) AS all_union
ORDER BY price DESC

-- Задача №5
-- Напишете заявка, която извежда производителя на цветния принтер с
-- най-ниска цена

SELECT maker
FROM product
WHERE model IN (SELECT model
		FROM printer
		WHERE color = 'y'
		      AND
		      price <= ALL (SELECT price
				    FROM printer
				    WHERE color = 'y'))

-- Задача №6
-- Напишете заявка, която извежда производителите на тези персонални
-- компютри с най-малко RAM памет, които имат най-бързи процесори.

SELECT maker
FROM product
WHERE model IN (SELECT model
		FROM pc AS opc  
		WHERE ram <= ALL (SELECT ram FROM pc)  
	              AND  
		      speed >= ALL (SELECT speed FROM pc WHERE ram = opc.ram));
