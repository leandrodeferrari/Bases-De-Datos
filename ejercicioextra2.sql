
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

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM jardineria.pedido 
WHERE adddate(fecha_entrega, interval 2 day);

### 
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

SELECT nombre_cliente, nombre FROM jardineria.cliente INNER JOIN jardineria.empleado 
INNER JOIN jardineria.pago ON cliente.codigo_cliente = pago.codigo_cliente AND cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

###
# 19. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.  



# 20. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la 
# oficina a la que pertenece el representante.  



# 21. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad 
# de la oficina a la que pertenece el representante.


  
# 22. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada. 



# 23. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina 
# a la que pertenece el representante.  



# 24. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.  



# 25. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.  



# 26. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente. 



# Consultas multitabla (Composición externa)  
# Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN. 
# 27. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  



# 28. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.  



# 29. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.  



# 30. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.  



# 31. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.  



# 32. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.  



# 33. Devuelve un listado de los productos que nunca han aparecido en un pedido.  



# 34. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas 
# de algún cliente que haya realizado la compra de algún producto de la gama Frutales.  



# 35. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.  



# 36. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.  



# Consultas resumen  
# 37. ¿Cuántos empleados hay en la compañía?  



# 38. ¿Cuántos clientes tiene cada país?  



# 39. ¿Cuál fue el pago medio en 2009?  



# 40. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.  



# 41. Calcula el precio de venta del producto más caro y más barato en una misma consulta.  



# 42. Calcula el número de clientes que tiene la empresa.  



# 43. ¿Cuántos clientes tiene la ciudad de Madrid?  



# 44. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?  



# 45. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.  



# 46. Calcula el número de clientes que no tiene asignado representante de ventas.  



# 47. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el 
# nombre y los apellidos de cada cliente.  



# 48. Calcula el número de productos diferentes que hay en cada uno de los pedidos.  



# 49. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.  



# 50. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
# El listado deberá estar ordenado por el número total de unidades vendidas.  



# 51. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
# La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
# El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.  



# 52. La misma información que en la pregunta anterior, pero agrupada por código de producto.  



# 53. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada 
# por los códigos que empiecen por OR.  



# 54. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, 
# unidades vendidas, total facturado y total facturado con impuestos (21% IVA).



# Subconsultas con operadores básicos de comparación 
# 55. Devuelve el nombre del cliente con mayor límite de crédito.  



# 56. Devuelve el nombre del producto que tenga el precio de venta más caro.  



# 57. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular 
# cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. 
# Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)  



# 58. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).  



# 59. Devuelve el producto que más unidades tiene en stock.  



# 60. Devuelve el producto que menos unidades tiene en stock.  



# 61. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.  



# Subconsultas con ALL y ANY.
# 62. Devuelve el nombre del cliente con mayor límite de crédito.  



# 63. Devuelve el nombre del producto que tenga el precio de venta más caro.  



# 64. Devuelve el producto que menos unidades tiene en stock.



# Subconsultas con IN y NOT IN
# 65. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.  



# 66. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  



# 67. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.  



# 68. Devuelve un listado de los productos que nunca han aparecido en un pedido.  



# 69. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean 
# representante de ventas de ningún cliente.



# Subconsultas con EXISTS y NOT EXISTS 
# 70. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.  



# 71. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.  



# 72. Devuelve un listado de los productos que nunca han aparecido en un pedido.  



# 73. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.  


