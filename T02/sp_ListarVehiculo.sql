
CREATE PROCEDURE sp_ListarVehiculo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ve.IdVehiculo,
        v.Cedula,
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
