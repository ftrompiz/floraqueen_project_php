-- Creates y Inserts de prueba

DROP TABLE CompraLineas;
DROP TABLE Compras;

DROP TABLE Clientes;
DROP TABLE Productos;
DROP TABLE Tiendas;

CREATE TABLE Clientes(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    telefono VARCHAR(50),
    email VARCHAR(50),
    codigo_postal VARCHAR(50),

    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

CREATE TABLE Productos(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL NOT NULL,

    CONSTRAINT producto_pk PRIMARY KEY (id)
);

CREATE TABLE Tiendas(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(200) NOT NULL,

    CONSTRAINT tienda_pk PRIMARY KEY (id)
);


CREATE TABLE Compras(
    id INTEGER NOT NULL AUTO_INCREMENT,
    cliente_id INTEGER NOT NULL,
    tienda_id INTEGER NOT NULL,
    total DECIMAL NOT NULL,
    fecha DATETIME,

    CONSTRAINT compra_pk PRIMARY KEY (id),
    CONSTRAINT compra_cliente_fk FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    CONSTRAINT compra_tienda_fk FOREIGN KEY (tienda_id) REFERENCES Tiendas(id)
);


CREATE TABLE CompraLineas(
    id INTEGER NOT NULL AUTO_INCREMENT,
    compra_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    unidades INTEGER,
    precio DECIMAL,

    CONSTRAINT compra_linea_pk PRIMARY KEY (id),
    CONSTRAINT compra_l_cliente_fk FOREIGN KEY (compra_id) REFERENCES Compras(id),
    CONSTRAINT compra_l_tienda_fk FOREIGN KEY (producto_id) REFERENCES Productos(id)
);


INSERT INTO Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Francisco','Trompiz','1@1.com','123','08023');
INSERT INTO Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Magaly','Bergueiro','2@2.com','123','09021');
INSERT INTO Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Jesus','Perez','3@3.com','123','10023');

INSERT INTO Productos ( nombre, precio) VALUES ('Nintendo Switch',300);
INSERT INTO Productos ( nombre, precio) VALUES ('PS5',450);
INSERT INTO Productos ( nombre, precio) VALUES ('XBOX',400);

INSERT INTO Tiendas( nombre, direccion) VALUES ('Corte Ingles','Gran Avenida Les Corts');
INSERT INTO Tiendas( nombre, direccion) VALUES ('Pc Componentes','Lesseps');
INSERT INTO Tiendas( nombre, direccion) VALUES ('Media Market','Marina');
INSERT INTO Tiendas( nombre, direccion) VALUES ('ING','Hospitaler');


INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (1,1,300,'2021-10-10 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (1,1,1,300);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (2,2,300,'2021-10-10 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (2,1,1,300);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,850,'2021-10-26 05:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,3,1,400);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,2,1,450);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,3,1,400);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (3,3,400,'2021-10-21 05:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (4,3,1,400);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (3,2,700,'2021-10-24 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,3,1,400);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,1,1,300);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,1,2,300);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (1,1,2250,'2021-09-10 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (6,2,5,450);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,5350,'2020-09-10 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,1,3,300);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,2,1,450);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,2,3,450);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,3,10,400);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (1,3,5100,'2020-09-10 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (8,1,2,300);
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (8,2,10,450);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (3,1,400,'2021-09-28 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (9,3,1,400);

INSERT INTO Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,900,'2021-08-31 01:26:09 AM');
INSERT INTO CompraLineas( compra_id, producto_id, unidades, precio) VALUES (10,3,2,450);
--
A) -- Dado un id de cliente, necesitamos saber en qué tiendas ha comprado
SELECT DISTINCT(T.id), T.nombre, T.direccion
FROM Clientes C
INNER JOIN Compras CO ON  CO.cliente_id = C.id
INNER JOIN Tiendas T ON  CO.tienda_id = T.id
WHERE C.id = 1;


B) -- Dada una id de tienda, queremos ordenar las compras del último mes por total comprado
SELECT CO.tienda_id as TiendaId, CO.id as CompraId, CO.total, CO.fecha
FROM Compras CO
WHERE CO.fecha >= (NOW() - INTERVAL 1 MONTH)
AND CO.tienda_id = 1
ORDER BY CO.total DESC

-- Si se desaea obtener la inforamcion de la tienda en la query
SELECT T.id  as TiendaId, CO.id as CompraId, CO.total, CO.fecha
FROM Tiendas T
INNER JOIN Compras CO ON  CO.tienda_id = T.id
WHERE CO.fecha >= (NOW() - INTERVAL 1 MONTH)
AND T.id = 1
ORDER BY CO.total DESC

C)-- Queremos saber en orden descendente las tiendas que más venden en número de ventas y total
SELECT CO.tienda_id as TiendaID, COUNT(CO.id) AS cantidad_ventas, SUM(CO.total) AS total_ventas
FROM Compras CO
GROUP BY CO.tienda_id
ORDER BY total_ventas DESC,cantidad_ventas DESC

-- Si se desea tener la informacion de la tienda utilizar la query de abajo
SELECT T.id as TiendaID, COUNT(CO.id) AS cantidad_ventas, SUM(CO.total) AS total_ventas
FROM Compras CO
INNER JOIN Tiendas T ON  T.id = CO.tienda_id
GROUP BY CO.tienda_id
ORDER BY cantidad_ventas DESC, total_ventas DESC

D) -- Queremos saber en qué tiendas compra la gente de un código postal en concreto
SELECT DISTINCT(T.id), T.nombre, T.direccion
FROM Tiendas T
INNER JOIN Compras CO ON  CO.tienda_id = T.id
INNER JOIN Clientes CL ON  CO.cliente_id = CL.id
WHERE CL.codigo_postal = '08023'

E) -- Queremos saber cuál es el producto que más se compra en cada tienda
SELECT T.id, T.nombre, PVT.producto_id, PVT.cantidad
FROM Tiendas T
INNER JOIN (
    SELECT CO.tienda_id, COL.producto_id, SUM(COL.unidades) AS cantidad,
           DENSE_RANK() OVER (PARTITION BY CO.tienda_id ORDER BY SUM(COL.unidades) DESC) AS Rank
    FROM Compras CO
    INNER JOIN CompraLineas COL ON COL.compra_id = CO.id
    GROUP BY COL.producto_id, CO.tienda_id
) PVT ON PVT.tienda_id = T.id
WHERE PVT.Rank = 1
