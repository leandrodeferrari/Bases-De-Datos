
# Abrir el script de la base de datos llamada “jardineria.sql” y ejecutarlo para crear 
# todas las tablas e insertar datos en las mismas. Deberá obtener un diagrama de entidad 
# relación igual al que se muestra a continuación:   
# A continuación, se deben realizar las siguientes consultas sobre la base de datos: 

# 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.  

SELECT codigo_oficina, ciudad FROM jardineria.oficina;

# 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.  

SELECT ciudad, telefono FROM jardineria.oficina WHERE pais = 'España';

# 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.  

SELECT nombre, apellido1, apellido2, email FROM jardineria.empleado WHERE codigo_jefe = 7;

# 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.  

SELECT puesto, nombre, apellido1, apellido2, email FROM jardineria.empleado WHERE codigo_jefe IS NULL;

# 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.  

SELECT nombre, apellido1, apellido2, puesto FROM jardineria.empleado WHERE puesto NOT IN 
(SELECT puesto FROM jardineria.empleado WHERE puesto = 'Representante Ventas');

# 6. Devuelve un listado con el nombre de los todos los clientes españoles.  

SELECT * FROM jardineria.cliente WHERE pais = 'Spain';

# 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.  

SELECT DISTINCT estado FROM jardineria.pedido;

# 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
# Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta: 
# a) Utilizando la función YEAR de MySQL. 
# b) Utilizando la función DATE_FORMAT de MySQL. 
# c) Sin utilizar ninguna de las funciones anteriores.

# a)
SELECT DISTINCT codigo_cliente FROM jardineria.pago WHERE YEAR(fecha_pago) = '2008';

# b)
SELECT codigo_cliente, DATE_FORMAT(fecha_pago, '%D-%M-%Y') AS fecha_pago FROM jardineria.pago 
WHERE YEAR(fecha_pago) = '2008' GROUP BY codigo_cliente;

# c)
SELECT DISTINCT codigo_cliente FROM jardineria.pago WHERE fecha_pago LIKE '%2008%';

# 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega 
# de los pedidos que no han sido entregados a tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM jardineria.pedido 
WHERE fecha_entrega > fecha_esperada OR fecha_entrega IS NULL;

# 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los 
# pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.  
# a) Utilizando la función ADDDATE de MySQL. 
# b) Utilizando la función DATEDIFF de MySQL. 

# a)
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM jardineria.pedido 
WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);

# b) 
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM jardineria.pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

# 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.  

SELECT * FROM jardineria.pedido WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009;

# 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.  

SELECT * FROM jardineria.pedido WHERE MONTH(fecha_entrega) = 01; 

# 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT * FROM jardineria.pago WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal' ORDER BY codigo_cliente DESC;
  
# 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.  Tenga en cuenta que no 
# deben aparecer formas de pago repetidas.

SELECT DISTINCT forma_pago FROM jardineria.pago;

# 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 
# 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar 
# los de mayor precio.

SELECT * FROM jardineria.producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;
  
# 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas 
# tenga el código de empleado 11 o 30.

SELECT * FROM jardineria.cliente WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11,30);

# Consultas multitabla (Composición interna).
# Las consultas se deben resolver con INNER JOIN.  
# 17. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.  

SELECT nombre_cliente, nombre, apellido1, apellido2 FROM jardineria.cliente 
INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

# 18. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.  

SELECT cliente.nombre_cliente, empleado.nombre 
FROM jardineria.cliente INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_cliente IN 
(SELECT DISTINCT cliente.codigo_cliente FROM jardineria.pago INNER JOIN jardineria.cliente ON cliente.codigo_cliente = pago.codigo_cliente);

# 19. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.  

SELECT cliente.nombre_cliente, empleado.nombre 
FROM jardineria.cliente INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_cliente IN 
(SELECT DISTINCT cliente.codigo_cliente FROM jardineria.pago WHERE cliente.codigo_cliente NOT IN 
(SELECT DISTINCT codigo_cliente FROM jardineria.pago));

# 20. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la 
# oficina a la que pertenece el representante.  

SELECT DISTINCT nombre_cliente, empleado.nombre AS nombre_representabte, oficina.ciudad AS ciudad_representante FROM jardineria.cliente 
INNER JOIN jardineria.pago ON cliente.codigo_cliente = pago.codigo_cliente 
INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN jardineria.oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

# 21. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad 
# de la oficina a la que pertenece el representante.

SELECT nombre_cliente, empleado.nombre AS nombre_representante, oficina.ciudad AS ciudad_representante FROM jardineria.cliente  
INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN jardineria.oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.codigo_cliente NOT IN (SELECT pago.codigo_cliente FROM jardineria.pago);

# 22. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada. 

SELECT oficina.linea_direccion1, oficina.linea_direccion2 FROM jardineria.cliente  
INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN jardineria.oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE cliente.codigo_cliente IN (SELECT codigo_cliente FROM jardineria.cliente WHERE ciudad = 'Fuenlabrada');

# 23. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina 
# a la que pertenece el representante.  

SELECT cliente.nombre_cliente, empleado.nombre AS nombre_representante, oficina.ciudad FROM jardineria.cliente
INNER JOIN jardineria.empleado ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
INNER JOIN jardineria.oficina ON empleado.codigo_oficina = oficina.codigo_oficina;

# 24. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.  

SELECT empleado.nombre, jefe.nombre_jefe FROM jardineria.empleado
INNER JOIN (SELECT empleado.codigo_empleado AS codigo_jefe, empleado.nombre AS nombre_jefe FROM jardineria.empleado) AS jefe
ON empleado.codigo_jefe = jefe.codigo_jefe;

# 25. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.  

SELECT DISTINCT cliente.nombre_cliente FROM jardineria.cliente INNER JOIN jardineria.pedido 
ON cliente.codigo_cliente = pedido.codigo_cliente WHERE fecha_entrega > fecha_esperada;

# 26. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente. 

SELECT DISTINCTROW producto.gama, pedido.codigo_cliente FROM jardineria.producto 
INNER JOIN jardineria.detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto 
INNER JOIN jardineria.pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido;

# Consultas multitabla (Composición externa)  
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN. 
# 27. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  

SELECT cliente.* FROM jardineria.cliente LEFT JOIN jardineria.pago 
ON cliente.codigo_cliente = pago.codigo_cliente WHERE pago.codigo_cliente IS NULL;

# 28. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.  

SELECT cliente.* FROM jardineria.cliente LEFT JOIN jardineria.pedido 
ON cliente.codigo_cliente = pedido.codigo_cliente WHERE pedido.codigo_cliente IS NULL;

# 29. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.  

SELECT cliente.* FROM jardineria.cliente LEFT JOIN jardineria.pedido 
ON cliente.codigo_cliente = pedido.codigo_cliente
LEFT JOIN jardineria.pago ON cliente.codigo_cliente = pago.codigo_cliente WHERE pedido.codigo_cliente IS NULL AND pago.codigo_cliente IS NULL;

# 30. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.  

SELECT empleado.* FROM jardineria.empleado LEFT JOIN jardineria.oficina 
ON empleado.codigo_oficina = oficina.codigo_oficina WHERE oficina.codigo_oficina IS NULL;

# 31. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.  

SELECT empleado.* FROM jardineria.empleado LEFT JOIN jardineria.cliente 
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas WHERE cliente.codigo_empleado_rep_ventas IS NULL; 

# 32. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.  

SELECT empleado.* FROM jardineria.empleado LEFT JOIN jardineria.oficina 
ON empleado.codigo_oficina = oficina.codigo_oficina LEFT JOIN jardineria.cliente 
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas 
WHERE oficina.codigo_oficina IS NULL AND cliente.codigo_empleado_rep_ventas IS NULL;

# 33. Devuelve un listado de los productos que nunca han aparecido en un pedido.  

SELECT producto.* FROM jardineria.producto LEFT JOIN jardineria.detalle_pedido 
ON producto.codigo_producto = detalle_pedido.codigo_producto 
WHERE detalle_pedido.codigo_producto IS NULL;

# 34. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas 
# de algún cliente que haya realizado la compra de algún producto de la gama Frutales.  

SELECT DISTINCTROW oficina.* FROM jardineria.oficina LEFT JOIN jardineria.empleado 
ON oficina.codigo_oficina = empleado.codigo_oficina INNER JOIN jardineria.cliente 
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas INNER JOIN jardineria.pedido 
ON cliente.codigo_cliente = pedido.codigo_cliente INNER JOIN jardineria.detalle_pedido 
ON pedido.codigo_pedido = detalle_pedido.codigo_pedido 
WHERE detalle_pedido.codigo_producto IN (SELECT codigo_producto FROM jardineria.producto WHERE gama = 'frutales') 
AND cliente.codigo_empleado_rep_ventas IS NULL;

# 35. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.  

SELECT DISTINCTROW cliente.* FROM jardineria.cliente INNER JOIN jardineria.pedido 
ON cliente.codigo_cliente = pedido.codigo_cliente LEFT JOIN jardineria.pago 
ON cliente.codigo_cliente = pago.codigo_cliente WHERE pago.codigo_cliente IS NULL;

# 36. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.  

SELECT empleado.* FROM jardineria.empleado LEFT JOIN jardineria.cliente 
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas 
WHERE cliente.codigo_empleado_rep_ventas IS NULL AND codigo_jefe IS NULL;

# Consultas resumen  
# 37. ¿Cuántos empleados hay en la compañía?  

SELECT COUNT(codigo_empleado) AS cantidad_empleados FROM jardineria.empleado;

# 38. ¿Cuántos clientes tiene cada país?  

SELECT pais, COUNT(codigo_cliente) AS cantidad_clientes FROM jardineria.cliente GROUP BY pais;

# 39. ¿Cuál fue el pago medio en 2009?  

SELECT AVG(total) AS promedio_pago FROM jardineria.pago WHERE fecha_pago LIKE '%2009%';

# 40. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.  

SELECT estado, COUNT(codigo_pedido) AS numero_de_pedidos FROM jardineria.pedido GROUP BY estado ORDER BY numero_de_pedidos DESC;

# 41. Calcula el precio de venta del producto más caro y más barato en una misma consulta.  

SELECT MIN(precio_venta) AS precio_minimo, MAX(precio_venta) AS precio_maximo FROM jardineria.producto;

# 42. Calcula el número de clientes que tiene la empresa.  

SELECT COUNT(codigo_cliente) AS cantidad_clientes FROM jardineria.cliente;

# 43. ¿Cuántos clientes tiene la ciudad de Madrid?  

SELECT COUNT(codigo_cliente) AS cantidad_clientes_de_madrid FROM jardineria.cliente WHERE ciudad = 'Madrid';

# 44. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?  

SELECT COUNT(codigo_cliente) AS cantidad_clientes_de_ciudades_con_c FROM jardineria.cliente WHERE ciudad LIKE 'M%';

# 45. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.  

SELECT empleado.nombre AS nombre_representante, COUNT(codigo_cliente) AS cantidad_clientes FROM jardineria.empleado INNER JOIN jardineria.cliente 
ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas GROUP BY nombre_representante;

# 46. Calcula el número de clientes que no tiene asignado representante de ventas.  

SELECT COUNT(codigo_cliente) cantidad_clientes_sin_representante FROM jardineria.cliente WHERE codigo_empleado_rep_ventas IS NULL;

# 47. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el 
# nombre y los apellidos de cada cliente.  

SELECT cliente.nombre_contacto, cliente.apellido_contacto, MIN(fecha_pago) AS primer_fecha_pago, MAX(fecha_pago) AS ultima_fecha_pago 
FROM jardineria.cliente INNER JOIN jardineria.pago ON cliente.codigo_cliente = pago.codigo_cliente GROUP BY pago.codigo_cliente;

# 48. Calcula el número de productos diferentes que hay en cada uno de los pedidos.  

SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS cantidad_productos FROM jardineria.detalle_pedido GROUP BY codigo_pedido;

# 49. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.  

SELECT SUM(cantidad) AS suma_total_cantidad_productos FROM jardineria.detalle_pedido;

# 50. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
# El listado deberá estar ordenado por el número total de unidades vendidas.  

SELECT codigo_producto, SUM(cantidad) AS suma_total_cantidad_productos FROM jardineria.detalle_pedido 
GROUP BY codigo_producto ORDER BY suma_total_cantidad_productos DESC LIMIT 20;

# 51. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
# La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
# El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.  

SELECT (SUM(base_imponible) + (SUM(base_imponible) * 0.21)) AS facturacion_de_la_empresa FROM 
(SELECT (SUM(cantidad) * precio_unidad) AS base_imponible FROM jardineria.detalle_pedido GROUP BY codigo_producto) AS base;

# 52. La misma información que en la pregunta anterior, pero agrupada por código de producto.  

SELECT codigo_producto, ROUND((base_imponible + (base_imponible * 0.21))) AS facturacion_por_producto FROM 
(SELECT codigo_producto, (SUM(cantidad) * precio_unidad) AS base_imponible FROM jardineria.detalle_pedido GROUP BY codigo_producto) AS base;

# 53. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada 
# por los códigos que empiecen por OR.  

SELECT codigo_producto, ROUND((base_imponible + (base_imponible * 0.21))) AS facturacion_por_producto FROM 
(SELECT codigo_producto, (SUM(cantidad) * precio_unidad) AS base_imponible FROM jardineria.detalle_pedido 
GROUP BY codigo_producto HAVING codigo_producto LIKE 'OR%') AS base;

# 54. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, 
# unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

SELECT producto.nombre, detalle_pedido.cantidad, ROUND(detalle_pedido.cantidad * detalle_pedido.precio_unidad) AS total_facturado, 
ROUND(((detalle_pedido.cantidad * detalle_pedido.precio_unidad) * 1.21)) AS total_mas_iva FROM jardineria.detalle_pedido INNER JOIN jardineria.producto 
ON detalle_pedido.codigo_producto = producto.codigo_producto;

# Subconsultas con operadores básicos de comparación 
# 55. Devuelve el nombre del cliente con mayor límite de crédito.  

SELECT cliente.nombre_cliente FROM jardineria.cliente WHERE limite_credito = (SELECT MAX(limite_credito) FROM jardineria.cliente);

# 56. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre FROM jardineria.producto WHERE precio_venta = (SELECT MAX(precio_venta) FROM jardineria.producto);

# 57. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular 
# cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. 
# Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)  

SELECT codigo_producto, cantidad FROM 
(SELECT codigo_producto, SUM(cantidad) AS cantidad FROM jardineria.detalle_pedido GROUP BY codigo_producto) AS cantidades 
WHERE cantidad = 
(SELECT MAX(cantidad) FROM (SELECT codigo_producto, SUM(cantidad) AS cantidad FROM jardineria.detalle_pedido GROUP BY codigo_producto) AS cantidades);

# 58. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).  

SELECT cliente.nombre_cliente, cliente.limite_credito, pago.total FROM jardineria.cliente, jardineria.pago WHERE pago.total = 
(SELECT MAX(pago.total) FROM jardineria.pago WHERE cliente.limite_credito > pago.total);

# 59. Devuelve el producto que más unidades tiene en stock.  

SELECT * FROM jardineria.producto WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM jardineria.producto);

# 60. Devuelve el producto que menos unidades tiene en stock.  

SELECT * FROM jardineria.producto WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM jardineria.producto);

# 61. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.  

SELECT nombre, apellido1, apellido2, email FROM jardineria.empleado WHERE codigo_jefe = 
(SELECT codigo_jefe FROM jardineria.empleado WHERE nombre = 'Alberto') AND nombre <> 'Alberto' AND apellido1 <> 'Soria';

# Subconsultas con ALL y ANY.
# 62. Devuelve el nombre del cliente con mayor límite de crédito.  

SELECT nombre_cliente FROM jardineria.cliente WHERE limite_credito >= ALL (SELECT limite_credito FROM jardineria.cliente);

# Resuelto con MAX()
SELECT nombre_cliente, limite_credito FROM jardineria.cliente WHERE limite_credito = (SELECT MAX(limite_credito) FROM jardineria.cliente);

# 63. Devuelve el nombre del producto que tenga el precio de venta más caro.  

SELECT nombre FROM jardineria.producto WHERE precio_venta >= ALL (SELECT precio_venta FROM jardineria.producto);

# 64. Devuelve el producto que menos unidades tiene en stock.

SELECT * FROM jardineria.producto WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM jardineria.producto);

# Subconsultas con IN y NOT IN
# 65. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.  

SELECT nombre, apellido1, puesto AS cargo FROM jardineria.empleado WHERE codigo_empleado 
NOT IN (SELECT codigo_empleado_rep_ventas FROM jardineria.cliente);

# 66. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  

SELECT * FROM jardineria.cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM jardineria.pago);

# 67. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.  

SELECT * FROM jardineria.cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM jardineria.pago);

# 68. Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT * FROM jardineria.producto WHERE codigo_producto NOT IN (SELECT codigo_producto FROM jardineria.detalle_pedido);

# 69. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean 
# representante de ventas de ningún cliente.

SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.puesto, oficina.telefono AS telefono_oficina FROM jardineria.empleado 
INNER JOIN jardineria.oficina ON empleado.codigo_oficina = oficina.codigo_oficina WHERE codigo_empleado NOT IN 
(SELECT cliente.codigo_empleado_rep_ventas FROM jardineria.cliente);

# Subconsultas con EXISTS y NOT EXISTS 
# 70. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  

SELECT * FROM jardineria.cliente WHERE NOT EXISTS 
(SELECT codigo_cliente FROM jardineria.pago WHERE cliente.codigo_cliente = pago.codigo_cliente);

# 71. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.  

SELECT * FROM jardineria.cliente WHERE EXISTS 
(SELECT pago.codigo_cliente FROM jardineria.pago WHERE cliente.codigo_cliente = pago.codigo_cliente);

# 72. Devuelve un listado de los productos que nunca han aparecido en un pedido.  

SELECT * FROM jardineria.producto WHERE NOT EXISTS 
(SELECT detalle_pedido.codigo_producto FROM jardineria.detalle_pedido WHERE detalle_pedido.codigo_producto = producto.codigo_producto);

# 73. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.  

SELECT * FROM jardineria.producto WHERE EXISTS 
(SELECT detalle_pedido.codigo_producto FROM jardineria.detalle_pedido WHERE detalle_pedido.codigo_producto = producto.codigo_producto);
