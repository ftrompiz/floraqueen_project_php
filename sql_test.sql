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

-- Si se desea tener la informacion de la tienda utilizar la instancia de abajo

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