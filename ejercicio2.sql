# 2. Abrir el script llamado “personal-inserts” y ejecutarlo de modo tal que se cree la base de datos 
# “personal”, se creen las tablas y se inserten todos los datos en las tablas.

#  A continuación, realizar las siguientes consultas sobre la base de datos personal: 

# 1. Obtener los datos completos de los empleados. 

SELECT * FROM empleados;

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







