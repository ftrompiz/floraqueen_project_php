-- Creates y Inserts de prueba

DROP TABLE CompraLineas;
DROP TABLE Compras;

DROP TABLE Clientes;
DROP TABLE Productos;
DROP TABLE Tiendas;

CREATE TABLE Clientes(
                         id INTEGER NOT NULL IDENTITY(1,1),
                         nombre VARCHAR(50),
                         apellidos VARCHAR(50),
                         telefono VARCHAR(50),
                         email VARCHAR(50),
                         codigo_postal VARCHAR(50),

                         CONSTRAINT cliente_pk PRIMARY KEY (id)
);

CREATE TABLE Productos(
                          id INTEGER NOT NULL IDENTITY(1,1),
                          nombre VARCHAR(50) NOT NULL,
                          precio DECIMAL NOT NULL,

                          CONSTRAINT producto_pk PRIMARY KEY (id)
);

CREATE TABLE Tiendas(
                        id INTEGER NOT NULL IDENTITY(1,1),
                        nombre VARCHAR(50) NOT NULL,
                        direccion VARCHAR(200) NOT NULL,

                        CONSTRAINT tienda_pk PRIMARY KEY (id)
);


CREATE TABLE Compras(
                        id INTEGER NOT NULL IDENTITY(1,1),
                        cliente_id INTEGER NOT NULL,
                        tienda_id INTEGER NOT NULL,
                        total DECIMAL NOT NULL,
                        fecha DATETIME,

                        CONSTRAINT compra_pk PRIMARY KEY (id),
                        CONSTRAINT compra_cliente_fk FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
                        CONSTRAINT compra_tienda_fk FOREIGN KEY (tienda_id) REFERENCES Tiendas(id)
);


CREATE TABLE CompraLineas(
                             id INTEGER NOT NULL IDENTITY(1,1),
                             compra_id INTEGER NOT NULL,
                             producto_id INTEGER NOT NULL,
                             unidades INTEGER,
                             precio DECIMAL,

                             CONSTRAINT compra_linea_pk PRIMARY KEY (id),
                             CONSTRAINT compra_l_cliente_fk FOREIGN KEY (compra_id) REFERENCES Compras(id),
                             CONSTRAINT compra_l_tienda_fk FOREIGN KEY (producto_id) REFERENCES Productos(id)
);


INSERT INTO dbo.Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Francisco','Trompiz','1@1.com','123','08023');
INSERT INTO dbo.Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Magaly','Bergueiro','2@2.com','123','09021');
INSERT INTO dbo.Clientes ( nombre, apellidos, email, telefono, codigo_postal) VALUES ('Jesus','Perez','3@3.com','123','10023');

INSERT INTO dbo.Productos ( nombre, precio) VALUES ('Nintendo Switch',300);
INSERT INTO dbo.Productos ( nombre, precio) VALUES ('PS5',450);
INSERT INTO dbo.Productos ( nombre, precio) VALUES ('XBOX',400);

INSERT INTO dbo.Tiendas( nombre, direccion) VALUES ('Corte Ingles','Gran Avenida Les Corts');
INSERT INTO dbo.Tiendas( nombre, direccion) VALUES ('Pc Componentes','Lesseps');
INSERT INTO dbo.Tiendas( nombre, direccion) VALUES ('Media Market','Marina');
INSERT INTO dbo.Tiendas( nombre, direccion) VALUES ('ING','Hospitaler');


INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (1,1,300,'20211010 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (1,1,1,300);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (2,2,300,'20211010 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (2,1,1,300);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,850,'20211026 05:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,3,1,400);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,2,1,450);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (3,3,1,400);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (3,3,400,'20211021 05:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (4,3,1,400);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (3,2,700,'20211024 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,3,1,400);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,1,1,300);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (5,1,2,300);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (1,1,2250,'20210910 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (6,2,5,450);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,5350,'20200910 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,1,3,300);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,2,1,450);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,2,3,450);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (7,3,10,400);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (1,3,5100,'20200910 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (8,1,2,300);
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (8,2,10,450);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (3,1,400,'20210928 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (9,3,1,400);

INSERT INTO dbo.Compras( cliente_id, tienda_id, total, fecha) VALUES (2,1,900,'20210831 01:26:09 AM');
INSERT INTO dbo.CompraLineas( compra_id, producto_id, unidades, precio) VALUES (10,3,2,450);
--
A)
SELECT DISTINCT(T.id), T.nombre, T.direccion
FROM dbo.Tiendas T, dbo.Compras CO
WHERE CO.tienda_id = T.id AND
        CO.cliente_id = 1;

B)
SELECT CO.id, CO.total
FROM dbo.Compras CO
WHERE DATEPART(m, CO.fecha) = DATEPART(m, DATEADD(m, -1, getdate())) AND
        DATEPART(yyyy, CO.fecha) = DATEPART(yyyy, DATEADD(m, -1, getdate())) AND
        CO.tienda_id = 1
ORDER BY CO.total DESC

C)
SELECT CO.tienda_id, COUNT(CO.id) AS cantidad_ventas, SUM(CO.total) AS total_ventas
FROM dbo.Compras CO
GROUP BY CO.tienda_id
ORDER BY total_ventas DESC,cantidad_ventas DESC

-- Si se desea tener la informacion de la tienda utilizar la query de abajo

WITH OrderTiendasTotalCantidad AS
(
	SELECT CO.tienda_id, COUNT(CO.id) AS cantidad_ventas, SUM(CO.total) AS total_ventas
	FROM dbo.Compras CO
	GROUP BY CO.tienda_id

)
SELECT T.id, T.nombre, T.direccion, OTTC.total_ventas, OTTC.cantidad_ventas
FROM dbo.Tiendas T, OrderTiendasTotalCantidad OTTC
WHERE T.id = OTTC.tienda_id
ORDER BY OTTC.total_ventas DESC, OTTC.cantidad_ventas DESC

D)
SELECT DISTINCT(T.id), T.nombre, T.direccion
FROM dbo.Tiendas T, dbo.Compras CO, dbo.Clientes CL
WHERE CO.tienda_id = T.id AND
        CO.cliente_id = CL.id AND
        CL.codigo_postal = '08023'

E)
WITH ProdVendTienda AS
(
    SELECT CO.tienda_id, COL.producto_id, SUM(COL.unidades) AS cantidad,
    DENSE_RANK() OVER (PARTITION BY CO.tienda_id ORDER BY SUM(COL.unidades) DESC) AS Rank
    FROM dbo.Compras CO, dbo.CompraLineas COL
    WHERE COL.compra_id = CO.id
    GROUP BY COL.producto_id, CO.tienda_id
)

SELECT T.id, T.nombre, T.direccion, PVT.producto_id, PVT.cantidad
FROM dbo.Tiendas T, ProdVendTienda PVT
WHERE PVT.tienda_id = T.id AND
        PVT.Rank = 1