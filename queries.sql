-- ПЕРЕХІД ДО БД

USE goit_rdb_hw_03;


-- ПУНКТ 1 — SUBQUERY В SELECT

SELECT 
    od.*,
    (
        SELECT o.customer_id
        FROM orders o
        WHERE o.id = od.order_id
    ) AS customer_id
FROM order_details od;

-- ПУНКТ 2 — SUBQUERY В WHERE

SELECT *
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);

-- ПУНКТ 3 — SUBQUERY В FROM

SELECT 
    sub.order_id,
    AVG(sub.quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS sub
GROUP BY sub.order_id;

-- ПУНКТ 4 — WITH (CTE)

WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- ================================
-- ПУНКТ 5 — FUNCTION
-- ================================

DROP FUNCTION IF EXISTS divide_quantity;

DELIMITER $$

CREATE FUNCTION divide_quantity(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END$$

DELIMITER ;

SELECT 
    quantity,
    divide_quantity(quantity, 2) AS divided_value
FROM order_details;
