/*

3. Importar el script de la base de datos llamada “pokemondb.sql” y ejecutarlo para crear todas las tablas 
e insertar los registros en las mismas. A continuación, generar el modelo de entidad relación y 
reorganizar las tablas para mayor claridad de sus relaciones.

*/

# A continuación, se deben realizar las siguientes consultas: 

#1. Mostrar el nombre de todos los pokemon. 

SELECT nombre FROM pokemondb.pokemon;

#2. Mostrar los pokemon que pesen menos de 10k. 

SELECT * FROM pokemondb.pokemon WHERE peso < 10;

#3. Mostrar los pokemon de tipo agua. 

SELECT pokemon.*, tipo.nombre FROM pokemondb.pokemon INNER JOIN pokemondb.pokemon_tipo 
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
INNER JOIN pokemondb.tipo ON tipo.id_tipo = pokemon_tipo.id_tipo
WHERE pokemon_tipo.id_tipo = (SELECT id_tipo FROM pokemondb.tipo WHERE nombre = 'Agua');

#4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo. 

SELECT pokemon.*, tipo.nombre FROM pokemondb.pokemon INNER JOIN pokemondb.pokemon_tipo 
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
INNER JOIN pokemondb.tipo ON tipo.id_tipo = pokemon_tipo.id_tipo
WHERE pokemon_tipo.id_tipo IN (SELECT id_tipo FROM pokemondb.tipo WHERE nombre IN ('Agua','Tierra','Fuego')) ORDER BY tipo.nombre ASC;

#5. Mostrar los pokemon que son de tipo fuego y volador. 

SELECT pokemon.*, tipo.nombre FROM pokemondb.pokemon INNER JOIN pokemondb.pokemon_tipo 
ON pokemon.numero_pokedex = pokemon_tipo.numero_pokedex
INNER JOIN pokemondb.tipo ON tipo.id_tipo = pokemon_tipo.id_tipo
WHERE pokemon_tipo.id_tipo IN (SELECT id_tipo FROM pokemondb.tipo WHERE nombre IN ('Volador','Fuego'));

#6. Mostrar los pokemon con una estadística base de ps mayor que 200. 

SELECT pokemon.*, estadisticas_base.ps FROM pokemondb.pokemon INNER JOIN pokemondb.estadisticas_base 
ON pokemon.numero_pokedex = estadisticas_base.numero_pokedex WHERE estadisticas_base.ps > 200;

#7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok. 

SELECT pokemon.* FROM pokemondb.pokemon WHERE pokemon.numero_pokedex = 
(SELECT evoluciona_de.pokemon_origen FROM pokemondb.evoluciona_de WHERE pokemon_evolucionado = 
(SELECT numero_pokedex FROM pokemondb.pokemon WHERE nombre = 'Arbok'));

#8. Mostrar aquellos pokemon que evolucionan por intercambio. 

SELECT * FROM pokemondb.pokemon WHERE numero_pokedex IN 
(SELECT numero_pokedex FROM pokemondb.pokemon_forma_evolucion WHERE id_forma_evolucion IN 
(SELECT id_forma_evolucion FROM pokemondb.forma_evolucion WHERE tipo_evolucion = 
(SELECT id_tipo_evolucion FROM pokemondb.tipo_evolucion WHERE tipo_evolucion = 'Intercambio')));

#9. Mostrar el nombre del movimiento con más prioridad. 

SELECT nombre FROM pokemondb.movimiento WHERE prioridad = (SELECT MAX(prioridad) FROM pokemondb.movimiento);

#10. Mostrar el pokemon más pesado. 

SELECT * FROM pokemondb.pokemon WHERE peso = (SELECT MAX(peso) FROM pokemondb.pokemon);

#11. Mostrar el nombre y tipo del ataque con más potencia. 

SELECT nombre,potencia FROM pokemondb.movimiento WHERE potencia = 
(SELECT MAX(potencia) FROM pokemondb.movimiento);

#12. Mostrar el número de movimientos de cada tipo. 

SELECT id_tipo, COUNT(id_movimiento) AS cantidad_movimientos FROM pokemondb.movimiento GROUP BY id_tipo;

#13. Mostrar todos los movimientos que puedan envenenar. 

SELECT movimiento.*, efecto_secundario.efecto_secundario FROM pokemondb.movimiento 
INNER JOIN pokemondb.movimiento_efecto_secundario ON movimiento.id_movimiento = movimiento_efecto_secundario.id_movimiento 
INNER JOIN pokemondb.efecto_secundario ON movimiento_efecto_secundario.id_efecto_secundario = efecto_secundario.id_efecto_secundario
WHERE efecto_secundario LIKE '%Envenena%';

#14. Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre. 

SELECT * FROM pokemondb.movimiento WHERE potencia = 0 ORDER BY nombre ASC;

#15. Mostrar todos los movimientos que aprende pikachu. 

SELECT id_movimiento AS id_movimienos_pikachu FROM pokemondb.pokemon_movimiento_forma WHERE numero_pokedex = 
(SELECT numero_pokedex FROM pokemondb.pokemon WHERE nombre = 'Pikachu');

#16. Mostrar todos los movimientos que aprende pikachu por MT (tipo de aprendizaje). 

SELECT id_forma_aprendizaje AS id_mt_pikachu FROM pokemondb.pokemon_movimiento_forma WHERE numero_pokedex = 
(SELECT numero_pokedex FROM pokemondb.pokemon WHERE nombre = 'Pikachu');

#17. Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel. 

SELECT movimiento.nombre FROM pokemondb.movimiento INNER JOIN pokemondb.pokemon_movimiento_forma ON 
movimiento.id_movimiento = pokemon_movimiento_forma.id_movimiento INNER JOIN pokemondb.pokemon ON
pokemon.numero_pokedex = pokemon_movimiento_forma.numero_pokedex INNER JOIN pokemondb.forma_aprendizaje ON
pokemon_movimiento_forma.id_forma_aprendizaje = forma_aprendizaje.id_forma_aprendizaje INNER JOIN pokemondb.tipo_forma_aprendizaje ON
forma_aprendizaje.id_tipo_aprendizaje = tipo_forma_aprendizaje.id_tipo_aprendizaje INNER JOIN pokemondb.tipo ON 
movimiento.id_tipo = tipo.id_tipo WHERE 
tipo.nombre = 'Normal' AND tipo_forma_aprendizaje.tipo_aprendizaje = 'Nivel' AND pokemon.nombre = 'Pikachu';

#18. Mostrar todos los movimientos de efecto secundario cuya probabilidad sea mayor al 30%. 

SELECT * FROM pokemondb.movimiento_efecto_secundario WHERE probabilidad > 30;

# 19. Mostrar todos los pokemon que evolucionan por piedra. 
	
SELECT pokemon.numero_pokedex, pokemon.nombre FROM pokemondb.pokemon INNER JOIN pokemondb.pokemon_forma_evolucion ON
pokemon.numero_pokedex = pokemon_forma_evolucion.numero_pokedex INNER JOIN pokemondb.forma_evolucion ON
pokemon_forma_evolucion.id_forma_evolucion = forma_evolucion.id_forma_evolucion INNER JOIN pokemondb.tipo_evolucion ON
forma_evolucion.tipo_evolucion = tipo_evolucion.id_tipo_evolucion WHERE tipo_evolucion.tipo_evolucion = 'Piedra';

#20. Mostrar todos los pokemon que no pueden evolucionar. 

SELECT pokemon.numero_pokedex, pokemon.nombre FROM pokemondb.pokemon INNER JOIN pokemondb.evoluciona_de ON 
pokemon.numero_pokedex = evoluciona_de.pokemon_evolucionado WHERE NOT EXISTS 
(SELECT evoluciona_de.pokemon_origen FROM pokemondb.evoluciona_de WHERE evoluciona_de.pokemon_origen = pokemon.numero_pokedex)
UNION
SELECT pokemon.numero_pokedex, pokemon.nombre FROM pokemondb.pokemon WHERE NOT EXISTS 
(SELECT * FROM pokemondb.evoluciona_de 
WHERE evoluciona_de.pokemon_origen = pokemon.numero_pokedex OR evoluciona_de.pokemon_evolucionado = pokemon.numero_pokedex);

# 21. Mostrar la cantidad de los pokemon de cada tipo. 

SELECT id_tipo, COUNT(numero_pokedex) AS cantidad_pokemon FROM pokemondb.pokemon_tipo GROUP BY id_tipo;
