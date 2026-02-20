CREATE OR ALTER PROCEDURE sp_ListarVehiculos
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		ve.IdVehiculo,
		ve.Marca,
		ve.Modelo,
		ve.Color,
		ve.Precio,
		v.Nombre AS Vendedor
	FROM Vehiculos ve
	INNER JOIN Vendedores v ON v.IdVendedor = ve.IdVendedor
	ORDER BY ve.IdVehiculo DESC;
END
GO