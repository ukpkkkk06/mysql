-- USE sql_store;

-- SELECT

--     customer_id,

--     first_name,

--     last_name,

--     SUM(oi.quantity * oi.unit_price) AS total_sales

-- FROM customers c

-- JOIN orders o USING(customer_id)

-- JOIN order_items oi USING(order_id)

-- WHERE state = 'VA'

-- GROUP BY

--     customer_id,

--     first_name,

--     last_name

-- HAVING total_sales > '100';

-- //having语句用于数据分组行之后，where用于原始数据；

-- use sql_invoicing;

-- SELECT

--     pm.name,

--     SUM(amount) AS total

-- FROM payments p

-- JOIN payment_methods pm

-- ON p.payment_method = pm.payment_method_id

-- GROUP BY

--     pm.name

--     WITH ROLLUP

-- //在使用rollup运算符时不能使用别名

-- //rollup运算符用于统计组的数据

-- use sql_hr;

-- SELECT *

-- FROM employees

-- WHERE salary > (         //子查询

--     SELECT

--     AVG(salary)

--     FROM employees

-- );

-- //此表子查询只返回了单一值👆

-- use sql_invoicing;

-- SELECT client_id

-- FROM clients

-- WHERE client_id NOT IN (

-- SELECT DISTINCT client_id

-- FROM invoices

-- );

-- // DISTINCT可以去除重复数据

-- USE sql_store;

-- SELECT

-- c.customer_id,

-- c.first_name,

-- c.last_name

-- FROM order_items oi

-- JOIN orders o

-- ON o.order_id = oi.order_id

-- JOIN customers c

-- ON c.customer_id = o.customer_id

-- WHERE c.customer_id NOT IN(

--     SELECT DISTINCT customer_id

--     FROM customers

--     WHERE oi.product_id != 3

-- )

-- GROUP BY

-- c.customer_id,

-- c.first_name,

-- c.last_name

-- ORDER BY customer_id;

-- //子查询解决

-- SELECT

-- customer_id,

-- first_name,

-- last_name

-- FROM order_items

-- LEFT JOIN orders USING (order_id)

-- LEFT JOIN customers USING (customer_id)

-- WHERE product_id = '3'

-- GROUP BY

-- customer_id,

-- first_name,

-- last_name

-- ORDER BY customer_id;

-- -- //连接方式解决，在有自然关系时更加易读

-- USE sql_invoicing;

-- SELECT *

-- FROM invoices i

-- WHERE invoice_total > (

--     SELECT AVG(invoice_total)

--     FROM invoices

--     WHERE client_id = i.client_id

-- );

-- //相关子查询，在该子查询中引用了外部查询↑

-- USE sql_store;

-- SELECT *

-- FROM products p

-- WHERE NOT EXISTS (

--     SELECT product_id

--     FROM order_items

--     WHERE product_id = p.product_id

-- );

-- USE

--     sql_invoicing;

-- SELECT

--     client_id,

--     name,

--     (SELECT SUM(invoice_total)

--         FROM invoices

--         WHERE client_id = c.client_id) AS total_sales,

--     (SELECT AVG(invoice_total) FROM invoices) AS average,

--     (SELECT total_sales - average) AS difference

-- FROM clients c

-- //相关子查询，在该子查询中引用了外部查询↑

--  SELECT ROUND(5.7446,2) //轮函数用于四舍五入；

-- SELECT TRUNCATE(5.3542,2)//用于截断数字;

-- SELECT CEILING(5.1)//用于返回大于或者等于这个数字的最小整数；

-- SELECT FLOOR(5.7)//返回小于或者等于这个数字的最小整数；

-- SELECT ABS(-5.2)//用于取绝对值；

-- SELECT RAND()//生成介于0-1的浮点数值；

-- SELECT LENGTH('UKPKKKK')//返回字符串有多少个字符；;

-- SELECT UPPER('ukpkkkk')//将字符串转化为大写;

-- SELECT LOWER('ukpkkkk')//将字符串转化为小写;

-- SELECT LTRIM('    sky')//去除前导空格;

-- SELECT RTRIM('sky   ')//去除尾随空格;

-- SELECT TRIM('    sky   ')//去除所有前导或者尾随空格;

-- SELECT LEFT('kingdergarten',4)//截取从左边开始的字符;

--        ↑ RIGHT//从右边开始

-- SELECT SUBSTRING('kindergarten',3,5)//截取从任何一位开始的任意长度字符,如果不给最后一位参数默认返回从设定开始字符到结尾的所有字符;

-- SELECT LOCATE('pkk','ukpkkkk')//返回字符串中字符位置；

-- SELECT REPLACE('ukpkkkkk','kkkkk','opop')//替换字符串中字符;

-- SELECT CONCAT('ukpk','kkk')//连接两个字符串;

-- SELECT NOW(),CURDATE(),CURTIME()//返回当前时间，返回当前日期，返回当前时间;

-- USE sql_store;

-- SELECT *

-- FROM orders

-- WHERE YEAR(order_date) >= (

--     SELECT EXTRACT (YEAR FROM NOW())

-- )

-- SELECT DATE_FORMAT(NOW(),'%d %M %Y');

-- SELECT TIME_FORMAT(NOW(),'%H: %i %p');

-- SELECT DATE_ADD(NOW(),INTERVAL 1 YEAR);

-- SELECT DATE_SUB(NOW(),INTERVAL 1 YEAR);

-- SELECT DATEDIFF('2019-01-05','2019-01-01');

-- SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:03');

-- use sql_store;

-- SELECT

--     order_id,

--     IFNULL(shipper_id,'Not assigned') AS shipper

-- FROM orders;

-- SELECT

--     order_id,

--     COALESCE(shipper_id,comments, 'Not assigned') AS shipper

-- FROM orders;

-- SELECT

--     CONCAT(first_name," ",last_name) AS customer,

--     IFNULL(phone,'Unknown') AS phone

-- FROM customers;

-- SELECT

--     product_id,

--     name,

--     COUNT(product_id) AS orders,

--     IF(COUNT(product_id) >= '2','Many times','once')

-- FROM order_items

-- JOIN products USING(product_id)

-- GROUP BY

--     product_id,

--     name

-- ORDER BY

--     product_id;

-- SELECT

--     CONCAT(first_name,' ',last_name) AS customer,

--     points,

--     CASE

--         WHEN points >= 3000 THEN 'Gold'

--         WHEN points >= 2000 THEN 'Silver'

--         ELSE  'Bronze'

--     END AS category

-- FROM customers

-- ORDER BY points DESC;

-- USE sql_invoicing;

-- CREATE VIEW sales_by_client AS

-- SELECT

--     c.client_id,

--     c.name,

--     SUM(invoice_total) AS total_sales

-- FROM clients c

-- JOIN invoices i USING (client_id)

-- GROUP BY client_id,name;

-- SELECT *

-- FROM sales_by_client

-- ORDER BY total_sales DESC

-- CREATE OR REPLACE VIEW clients_balance AS

-- SELECT

-- c.client_id,

-- c.name,

-- SUM(invoice_total - payment_total) AS balance

-- FROM payments p

-- RIGHT JOIN clients c USING(client_id)

-- RIGHT JOIN invoices i USING(client_id)

-- GROUP BY

-- c.client_id

-- ORDER BY

-- client_id

-- WITH OPTION CHECK;

-- SELECT *

-- FROM clients_balance;

-- USE sql_invoicing;

-- DELIMITER $$

-- CREATE PROCEDURE get_clients()

-- BEGIN

--     SELECT * FROM clients;

-- END$$

-- DELIMITER ;

-- CALL get_clients();

-- USE sql_invoicing;

-- DELIMITER $$

-- CREATE PROCEDURE get_invoices_with_balance()

-- BEGIN

-- SELECT *

--     FROM invoices

--     WHERE invoice_total - payment_total > 0;

-- END$$

-- DELIMITER ;

-- CALL get_invoices_with_balance()

-- DELIMITER $$

-- CREATE PROCEDURE get_invoices_by_client(

--     p_client_id INT

-- )

-- BEGIN

-- SELECT * FROM clients c

-- WHERE c.client_id = p_client_id;

-- END$$

-- DELIMITER ;

-- CALL get_invoices_by_client(2)

-- USE sql_invoicing;

-- DELIMITER $$

-- CREATE PROCEDURE get_payments(

--     p_client_id INT,

--     p_payment_method_id TINYINT

-- )

-- BEGIN

--     SELECT *

--     FROM payments p

--     WHERE

--     p.client_id = IFNULL(p_client_id,p.client_id)

--     AND p.payment_method = IFNULL(p_payment_method_id,p.payment_method)

--     ;

-- END$$

-- CALL get_payments(5,2);

-- SHOW PROCEDURE STATUS;

-- USE sql_invoicing;

-- DELIMITER $$

-- CREATE TRIGGER payments_after_delete

--     AFTER DELETE ON payments

--     FOR EACH ROW

-- BEGIN

--     UPDATE invoices

--     SET payment_total = payment_total - OLD.amount

--     WHERE invoice_id = OLD.invoice_id;

-- END $$

-- DELIMITER ;

-- DROP TRIGGER IF EXISTS payments_after_insert;

-- SHOW TRIGGERS;

-- SHOW VARIABLES LIKE 'event%';

-- SELECT NOW()-INTERVAL 4 year;

-- SHOW EVENTS;

-- SELECT DISTINCT client_id

-- FROM payments;

-- SHOW VARIABLES LIKE 'autocommit';
USE sql_store;
SHOW VARIABLES LIKE 'transaction_isolation';
