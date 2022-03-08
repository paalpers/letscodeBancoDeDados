Consultas
Na tabela Customers:
1) Gere uma relação com os nomes dos clientes, 
suas cidades e países, em ordem alfabética de nome.
SELECT contact_name, city, country 
FROM customers
ORDER BY contact_name;

2) Na relação do item (1), filtre pelos clientes da Alemanha, 
da França e da Espanha, excluindo-se os clientes que vivem 
nas capitais destes países.
SELECT contact_name, city, country
FROM customers
WHERE country IN ('Germany', 'France', 'Spain') AND
city NOT IN ('Berlin', 'Madrid', 'Paris') 
ORDER BY contact_name;

SELECT contact_name, city, country, COUNT(*) 
FROM customers 
WHERE 
	(country='Germany' AND city !='Berlin') OR
	(country='France' AND city!='Paris') OR
	(country='Spain' AND city!='Madrid') 
GROUP BY country, contact_name, city;
ORDER BY contact_name;


Na tabela Products:
1) Quantos são os produtos que são da CategoryID 2?
SELECT product_name, COUNT(*) FROM products 
WHERE category_id = 2
GROUP BY 1;
2) Quantos produtos com SupplierID idêntico ao 
CategoryID e que custam mais do que 19?
SELECT COUNT(*) FROM products 
WHERE supplier_id = category_id AND unit_price > 19; 

3) Liste todos os nomes de produtos, 
suas *"Units"* e seus respectivos preços distintos 
que pertecem às categorias 1, 2 e 7.
SELECT product_name, 
	   unit_price, 
	   units_in_stock, 
	   units_on_order, 
	   quantity_per_unit
FROM products
WHERE category_id IN (1, 2, 7);

4) Liste os 5 primeiros nomes de produtos que começam 
com "A" ou tenham "h" no meio do nome.
SELECT * FROM products
WHERE product_name LIKE 'A%' OR product_name ILIKE '%h%'
ORDER BY product_id;

5) Dê a média de preços de todos os produtos das categorias 
entre 1 e 5.
SELECT category_id, AVG(unit_price)
	FROM products
	WHERE category_id IN (1, 2, 3, 4, 5)
GROUP BY category_id
ORDER BY category_id, AVG(unit_price);