
--(a)
SELECT o.sid AS pid, pro.names AS pro.names, CONT(o.quntitys) AS quntitys
FROM produtctsche o
JOIN products pro ON o.pid = pro.id
WHERE o.sid = ? -- id do pedido
GROUP BY o.pid, pro.names;

-- (b)
DALIMITER // 
CREAT PROCEDURE limitar_pedidos ()
    BEGIN
        DELETE FROM orders
        WHERE statu NOT IN ('open', 'payment');
    END //
DELIMITER ;

-- (c)
DELIMITER //
CREATE PROCEDURE UpdateProductQuantity(
    IN p_sid INT,
    IN p_pid INT,
    IN p_quantity INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM productsche WHERE sid = p_sid AND pid = p_pid) THEN
        UPDATE productsche
        SET quantity = p_quantity
        WHERE sid = p_sid AND pid = p_pid;
    ELSE
        INSERT INTO productsche (sid, pid, quantity)
        VALUES (p_sid, p_pid, p_quantity);
    END IF;
END //

DELIMITER ;

-- (d)
SELECT 
    p.name AS product_name,
    ps.quantity,
    p.price AS unit_price,
    (ps.quantity * p.price) AS total_product_value,
    (SELECT SUM(ps2.quantity * p2.price) 
     FROM productsche ps2
     JOIN products p2 ON ps2.pid = p2.id
     WHERE ps2.sid = ps.sid) AS total_order_value
FROM productsche ps
JOIN products p ON ps.pid = p.id
WHERE ps.sid = ?; -- Filtra os produtos para um pedido específico.