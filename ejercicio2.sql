# 2. Abrir el script llamado “personal-inserts” y ejecutarlo de modo tal que se cree la base de datos 
# “personal”, se creen las tablas y se inserten todos los datos en las tablas.

#  A continuación, realizar las siguientes consultas sobre la base de datos personal: 

# 1. Obtener los datos completos de los empleados. 

SELECT * FROM personal.empleados;

# 2. Obtener los datos completos de los departamentos. 

SELECT * FROM departamentos;

# 3. Listar el nombre de los departamentos.

SELECT nombre_depto FROM personal.departamentos;

# 4. Obtener el nombre y salario de todos los empleados.

SELECT nombre, sal_emp FROM personal.empleados;

# 5. Listar todas las comisiones.

SELECT comision_emp FROM personal.empleados;

# 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.

SELECT * FROM personal.empleados WHERE cargo_emp = 'Secretaria';

# 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.

SELECT * FROM personal.empleados WHERE cargo_emp = 'Vendedor' ORDER BY nombre ASC;

# 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor. 

SELECT nombre, cargo_emp, sal_emp FROM personal.empleados ORDER BY sal_emp ASC;

# 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas 
# tablas de empleados.  

SELECT nombre AS Nombre, cargo_emp AS Cargo FROM personal.empleados;

# 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión 
# de menor a mayor. 

SELECT sal_emp, comision_emp FROM personal.empleados WHERE id_depto = 2000 ORDER BY comision_emp ASC; 

# 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados 
# del departamento 3000 una bonificación de 500, en orden alfabético del empleado. 

SELECT nombre, id_depto, (sal_emp + comision_emp + 500) AS total_a_pagar FROM personal.empleados WHERE id_depto = 3000 ORDER BY nombre ASC;

# 12. Muestra los empleados cuyo nombre empiece con la letra J.

SELECT * FROM personal.empleados WHERE nombre LIKE 'J%';

# 13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que 
# tienen comisión superior a 1000.  

SELECT sal_emp, comision_emp, (sal_emp + comision_emp) AS salario_total, nombre FROM personal.empleados 
WHERE comision_emp > 1000;

# 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.

SELECT sal_emp, comision_emp, (sal_emp + comision_emp) AS salario_total, nombre FROM personal.empleados
WHERE comision_emp = 0;

# 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.

SELECT * FROM personal.empleados WHERE (comision_emp > sal_emp);

# 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.

SELECT * FROM personal.empleados WHERE (comision_emp <= (sal_emp*0.30));

# 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”

SELECT * FROM personal.empleados WHERE nombre <> '%Ma%';

# 18. 18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación” ni ‘Mantenimiento.  


