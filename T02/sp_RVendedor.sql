
CREATE OR ALTER PROCEDURE sp_RVendedor
	@Cedula VARCHAR(50),
	@Nombre VARCHAR(100),
	@Correo VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Vendedores (Cedula, Nombre, Correo, Estado)
	VALUES (@Cedula, @Nombre, @Correo, 1);
END
GO
