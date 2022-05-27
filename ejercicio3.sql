
# 1. Lista el nombre de todos los productos que hay en la tabla producto.

SELECT nombre FROM tienda.producto;

# 2. Lista los nombres y los precios de todos los productos de la tabla producto. 

SELECT nombre, precio FROM tienda.producto;

# 3. Lista todas las columnas de la tabla producto.

SELECT * FROM tienda.producto;

# 4. Lista los nombres y los precios de todos los productos de la tabla producto, 
# redondeando el valor del precio. 

SELECT nombre, ROUND(precio,0) AS precio FROM tienda.producto;

# 5. Lista el código de los fabricantes que tienen productos en la tabla producto.

SELECT codigo_fabricante FROM tienda.producto;

# 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos. 

SELECT codigo_fabricante FROM tienda.producto GROUP BY codigo_fabricante;

# 7. Lista los nombres de los fabricantes ordenados de forma ascendente.

SELECT nombre FROM tienda.fabricante ORDER BY nombre ASC;

# 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente
#  y en segundo lugar por el precio de forma descendente. 

SELECT * FROM tienda.producto ORDER BY nombre ASC, precio DESC;

# 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.  

SELECT * FROM tienda.fabricante LIMIT 5;

# 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT).

SELECT nombre, precio FROM tienda.producto ORDER BY precio ASC LIMIT 1;

# 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT).

SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1;

# 12. Lista el nombre de los productos que tienen un precio menor o igual a $120. 

SELECT nombre, precio FROM tienda.producto WHERE precio <= 120;

# 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN. 

SELECT * FROM tienda.producto WHERE precio BETWEEN 60 AND 200; 

# 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.

SELECT * FROM tienda.producto WHERE codigo_fabricante IN (1,3,5);

# 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre. 

SELECT nombre FROM tienda.producto WHERE nombre LIKE '%Portátil%';

# Consultas Multitabla
# 16. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre 
# del fabricante, de todos los productos de la base de datos.

SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre
FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo;

# 17. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos 
# de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.

SELECT producto.nombre, producto.precio, fabricante.nombre 
FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY fabricante.nombre ASC;

# 18. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato. 

SELECT producto.nombre, MIN(precio) AS precio, fabricante.nombre FROM tienda.producto INNER JOIN tienda.fabricante
ON producto.codigo_fabricante = fabricante.codigo;

# 19. Devuelve una lista de todos los productos del fabricante Lenovo. 

SELECT producto.codigo, producto.nombre, precio, codigo_fabricante, fabricante.nombre 
FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre = 'Lenovo';

# 20. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.

SELECT * FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

# 21. Devuelve un listado con todos los productos de los fabricantes Asus, HewlettPackard. Utilizando el operador IN.

SELECT * FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard');

# 22. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que 
# tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) 
# y en segundo lugar por el nombre (en orden ascendente).

SELECT producto.nombre, producto.precio, fabricante.nombre FROM tienda.producto INNER JOIN tienda.fabricante 
ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 
ORDER BY producto.precio DESC, producto.nombre ASC;

# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
# 23. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos 
# que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos 
# asociados.

SELECT * FROM tienda.fabricante LEFT JOIN tienda.producto ON fabricante.codigo = producto.codigo_fabricante;

# 24. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.

# SELECT * FROM tienda.fabricante WHERE codigo NOT IN (SELECT producto.codigo_fabricante FROM tienda.producto).

SELECT * FROM tienda.fabricante LEFT JOIN tienda.producto ON fabricante.codigo = producto.codigo_fabricante 
WHERE producto.codigo_fabricante IS NULL;

# Subconsultas (En la cláusula WHERE).
# Con operadores básicos de comparación.
# 25. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).

SELECT * FROM tienda.producto WHERE producto.codigo_fabricante =
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Lenovo');

# 26. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del 
# fabricante Lenovo. (Sin utilizar INNER JOIN).

SELECT * FROM tienda.producto WHERE precio = 
(SELECT MAX(precio) FROM tienda.producto WHERE codigo_fabricante = 
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Lenovo'));

# 27. Lista el nombre del producto más caro del fabricante Lenovo.

SELECT producto.nombre FROM tienda.producto WHERE precio = 
(SELECT MAX(precio) FROM tienda.producto WHERE codigo_fabricante = 
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Lenovo'));

# 28. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos 
# sus productos.

SELECT * FROM tienda.producto WHERE codigo_fabricante = 
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Asus') AND precio > 
(SELECT AVG(precio) FROM tienda.producto WHERE codigo_fabricante = 
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Asus'));

# Subconsultas con IN y NOT IN.
# 29. Devuelve los nombres de los fabricantes que tienen productos asociados.  (Utilizando IN o NOT IN).

SELECT fabricante.nombre FROM tienda.fabricante WHERE fabricante.codigo IN 
(SELECT codigo_fabricante FROM tienda.producto);

# 30. Devuelve los nombres de los fabricantes que no tienen productos asociados.  (Utilizando IN o NOT IN).

SELECT fabricante.nombre FROM tienda.fabricante WHERE codigo NOT IN 
(SELECT codigo_fabricante FROM tienda.producto);

# Subconsultas (En la cláusula HAVING)
# 31. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos 
# que el fabricante Lenovo.  

SELECT fabricante.nombre FROM tienda.fabricante WHERE fabricante.codigo IN 
(SELECT producto.codigo_fabricante FROM tienda.producto GROUP BY codigo_fabricante HAVING COUNT(codigo_fabricante) = 
(SELECT COUNT(producto.codigo_fabricante) FROM tienda.producto GROUP BY producto.codigo_fabricante HAVING producto.codigo_fabricante = 
(SELECT fabricante.codigo FROM tienda.fabricante WHERE fabricante.nombre = 'Lenovo') AND fabricante.nombre <> 'Lenovo'));
