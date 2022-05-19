
# 1. Abrir el script llamado “superhéroes” y ejecutarlo de modo tal que se cree la base de datos y todas sus tablas.
# a) Insertar en las tablas creadas los siguientes datos: 

INSERT INTO superheroes.creador (id_creador, nombre) VALUES (1, 'Marvel'), (2, 'DC Comics');

INSERT INTO superheroes.personajes (id_personaje, nombre_real, personaje, inteligencia, fuerza, velocidad, poder, 
 aparicion, ocupacion, id_creador) VALUES (1,'Bruce Banner','Hulk',160,'600 mil',75,98,1962,'Fíico Nuclear',1), 
 (2,'Tony Stark','Iron Man',170,'200 mil',70,123,1963,'Inventor industrial',1), 
 (3,'Thor Odinson','Thor',145,'infinita',100,235,1962,'Rey de Asgard',1), 
 (4,'Wanda Maximoff','Bruja Escarlata',170,'100 mil',90,345,1964,'Bruja',1), 
 (5,'Carol Danvers','Capitana Marvel',157,'250 mil',85,128,1968,'Oficial de Inteligencia',1),
 (6,'Thanos','Thanos',170,'infinita',40,306,1973,'Adorador de la muerte',1),
 (7,'Peter Parker','Spiderman',165,'25 mil',80,74,1962,'Fotógrafo',1),
 (8,'Steve Rogers','Capitan America',145,'600',45,60,1941,'Oficial Federal',1),
 (9,'Bobby Drake','Ice Man',140,'2 mil',64,122,1963,'Contador',1),
 (10,'Barry Allen','Flash',160,'10 mil',120,168,1956,'Científico forense',2),
 (11,'Bruce Wayne','Batman',170,'500',32,47,1939,'Hombre de negocios',2),
 (12,'Clark Kent','Superman',165,'infinita',120,182,1948,'Reportero',2),
 (13,'Diana Prince','Mujer Maravilla',160,'infinita',95,127,1949,'Princesa guerrera',2);

#a) Una vez insertados todos los registros realizar una selección de todos los atributos para corroborar 
# que la tablas se encuentren completas. 

SELECT * FROM superheroes.creador;
SELECT * FROM superheroes.personajes;

#b) Cambiar en la tabla personajes el año de aparición a 1938 del personaje Superman. A continuación, 
# realizar un listado de toda la tabla para verificar que el personaje haya sido actualizado.  

UPDATE superheroes.personajes SET aparicion = 1938 WHERE id_personaje = 12;

SELECT id_personaje, personaje, aparicion FROM superheroes.personajes WHERE id_personaje = 12;

#c) El registro que contiene al personaje Flash. A continuación, mostrar toda la tabla para verificar 
# que el registro haya sido eliminado.

DELETE FROM superheroes.personajes WHERE id_personaje = 10;

#d) Eliminar la base de datos superhéroes.

DROP SCHEMA superheroes;