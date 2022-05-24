
# 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.  

SELECT Nombre FROM nba.jugadores ORDER BY nombre ASC;

# 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, 
# ordenados por nombre alfabéticamente.  

SELECT Nombre, Posicion, Peso FROM nba.jugadores WHERE Posicion = 'C' AND Peso > 200 ORDER BY Nombre ASC;

# 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.

SELECT Nombre FROM nba.equipos ORDER BY Nombre ASC;

# 4. Mostrar el nombre de los equipos del este (East).

SELECT Nombre FROM nba.equipos WHERE Conferencia = 'East';

# 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.

SELECT Nombre, Ciudad FROM nba.equipos WHERE Ciudad LIKE 'C%' ORDER BY Nombre ASC;

# 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.  

SELECT Nombre, Nombre_equipo FROM nba.jugadores ORDER BY Nombre_equipo ASC;

# 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.

SELECT * FROM nba.jugadores WHERE Nombre_equipo = 'Raptors';

# 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’. 

SELECT Puntos_por_partido FROM nba.estadisticas WHERE jugador = 
(SELECT codigo FROM nba.jugadores WHERE Nombre = 'Pau Gasol');

# 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.  

SELECT Puntos_por_partido FROM nba.estadisticas WHERE jugador = 
(SELECT codigo FROM nba.jugadores WHERE Nombre = 'Pau Gasol') AND temporada = '04/05';

# 10. Mostrar el número de puntos de cada jugador en toda su carrera. 

SELECT jugador, SUM(Puntos_por_partido) AS puntos_totales FROM nba.estadisticas GROUP BY jugador;

# 11. Mostrar el número de jugadores de cada equipo.

SELECT Nombre_equipo, COUNT(Nombre_equipo) AS numero_de_jugadores FROM nba.jugadores GROUP BY Nombre_equipo;

# 12. Mostrar el jugador que más puntos ha realizado en toda su carrera. 

SELECT jugador, MAX(Puntos_por_partido) AS total_puntos FROM nba.estadisticas GROUP BY jugador 
HAVING Puntos_por_partido = (SELECT SUM(Puntos_por_partido) FROM nba.estadisticas GROUP BY jugador);

#####
# 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA. 

SELECT Nombre, Conferencia, Division FROM nba.equipos WHERE Nombre = 
(SELECT Nombre_equipo FROM jugadores WHERE altura = 
(SELECT MAX(altura) FROM nba.jugadores));

# 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific. 
                                     
SELECT Puntos_por_partido FROM nba.estadisticas WHERE jugador IN 
(SELECT codigo FROM nba.jugadores WHERE Nombre_equipo IN 
(SELECT nombre FROM nba.equipos WHERE Division = 'Pacific'));
# Falta AVG()
SELECT Puntos_por_partido FROM nba.estadisticas INNER JOIN nba.jugadores ON estadisticas.jugador = jugadores.codigo 
WHERE Nombre_equipo IN (SELECT nombre FROM nba.equipos WHERE Division = 'Pacific');
# FALTA AVG()
####
# 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos. 

SELECT codigo, equipo_local, equipo_visitante, (puntos_local - puntos_visitante) AS diferencia FROM nba.partidos;
# Falta lo de mayor diferencia
####
# 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific. 



# 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.  



# 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), 
# en caso de empate sera null. 

