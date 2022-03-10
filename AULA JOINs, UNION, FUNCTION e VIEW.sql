---INNER JOIN
SELECT ord.order_id, cust.contact_name
FROM orders AS ord
INNER JOIN customers AS cust ON ord.customer_id = cust.customer_id
ORDER BY cust.contact_name;

---INNER JOIN 2
SELECT cust.contact_name, COUNT(ord.order_id)
FROM orders AS ord
INNER JOIN customers AS cust ON ord.customer_id = cust.customer_id
GROUP BY 1 
ORDER BY COUNT(ord.order_id) DESC;

SELECT * FROM orders WHERE order_id = 10917; 
SELECT * FROM customers WHERE customer_id = 'ROMEY';
INSERT INTO customers(
	customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
	VALUES ('TESTE', 'TESTE TESTE', 'TESTE EMPRESA', 
			'TESTE CONTATO', 'TESTE ENDEREÇO', 'TESTE CIDADE', 
			'TESTE REGIÃO', '37258-300', 'TESTE PAIS', '(35) 95545-5585', '(35) 5545-5585');
--LEFT JOIN
SELECT ord.order_id, cust.customer_id
FROM orders AS ord
LEFT JOIN customers AS cust ON ord.customer_id = cust.customer_id
ORDER BY cust.contact_name;

--RIGHT JOIN
SELECT ord.order_id, cust.customer_id
FROM orders AS ord
RIGHT JOIN customers AS cust ON ord.customer_id = cust.customer_id
ORDER BY cust.customer_id;

SELECT COUNT(*) FROM orders; 
SELECT COUNT(*) FROM customers; 

--LEFT JOIN
SELECT cust.contact_name, ord.order_id
FROM customers AS cust
LEFT JOIN orders AS ord ON cust.customer_id = ord.customer_id
ORDER BY cust.contact_name;

---FULL JOIN
SELECT ord.order_id, cust.contact_name
FROM orders AS ord
FULL JOIN customers AS cust ON ord.customer_id = cust.customer_id
ORDER BY cust.contact_name; 

---UNION
SELECT city FROM customers
UNION 
SELECT city FROM suppliers

---UNION ALL
SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers

---STORE POCEDURE
CREATE FUNCTION NomeContato(p_order_id INTEGER) RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE r_contato VARCHAR(40);
BEGIN 	
	IF p_order_id IS NULL THEN
		123
	END IF;
	
	SELECT cust.contact_name INTO r_contato FROM orders AS ord
	INNER JOIN customers AS cust ON ord.customer_id = cust.customer_id
	WHERE ord.order_id = p_order_id;
		
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Não existe contato';
	END IF;
	
	RETURN r_contato;
END$$;

SELECT NomeContato(10917);

CREATE FUNCTION juntaTexto(p_texto_um VARCHAR(20), p_texto_dois VARCHAR(20))
RETURNS VARCHAR(20)
LANGUAGE sql
AS $$
SELECT CASE 
	WHEN p_texto_dois IS NULL THEN p_texto_um
	WHEN P_texto_um IS NULL THEN p_texto_dois
	ELSE p_texto_um || '/' || p_texto_dois
END$$;

SELECT juntaTexto('Teste 1', 'Teste 2');

CREATE FUNCTION f_numeroAoQuadrado(p_numero INTEGER) RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
RETURN p_numero * p_numero;
END$$;

SELECT numeroAoQuadrado(2);

---VIEWS
CREATE VIEW vw_Preco_Medio_Produtos
AS
SELECT DISTINCT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price;

SELECT * FROM products WHERE product_name = 'Ikura'
UPDATE products SET unit_price = 53
WHERE product_id = 10;
SELECT product_name, unit_price FROM vw_Preco_Medio_Produtos;

CREATE VIEW FATURA
AS 
SELECT DISTINCT
	ord.order_id,
	ord.ship_name AS NOME,
	ord.ship_address AS "ENDEREÇO",
	ord.ship_city AS "CIDADE",
	ord.ship_region AS "REGIÃO",
	ord.ship_postal_code AS "CEP",
	ord.ship_country AS "PAÍS",
	cust.company_name,
	ord.order_date,
	ord.shipped_date,
	concat(emp.first_name, '', emp.last_name) AS "NOME COMPLETO",
	ordd.unit_price * ordd.quantity * (1 - ordd.discount) AS "NOVO PREÇO"
FROM shippers AS ship
INNER JOIN orders AS ord ON ship.shipper_id = ord.ship_via
INNER JOIN customers AS cust ON ord.customer_id = cust.customer_id
INNER JOIN employees AS emp ON ord.employee_id = emp.employee_id
INNER JOIN order_details AS ordd ON ord.order_id = ordd.order_id
INNER JOIN products AS prod ON ordd.product_id = prod.product_id
ORDER BY ord.ship_name;

SELECT order_id, nome, "ENDEREÇO", "CIDADE", "REGIÃO", "CEP", "PAÍS", company_name, order_date, shipped_date, "NOME COMPLETO", "NOVO PREÇO"
	FROM public.fatura;
	
SELECT * FROM order_details WHERE product_id = 63


