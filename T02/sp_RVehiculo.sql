CREATE OR ALTER PROCEDURE sp_RVehiculo
	@Marca VARCHAR(100),
	@Modelo VARCHAR(100),
	@Color VARCHAR(100),
	@Precio DECIMAL(18,2),
	@IdVendedor BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Vehiculos (Marca, Modelo, Color, Precio, IdVendedor)
	VALUES (@Marca, @Modelo, @Color, @Precio,@IdVendedor);
END
GO