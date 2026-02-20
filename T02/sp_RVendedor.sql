
CREATE OR ALTER PROCEDURE sp_RVendedor
	@Cedula VARCHAR(50),
	@Nombre VARCHAR(100),
	@Correo VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	-- Validaciones básicas
    IF (@Cedula IS NULL OR LTRIM(RTRIM(@Cedula)) = '') RETURN -2;
    IF (@Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = '') RETURN -3;
    IF (@Correo IS NULL OR LTRIM(RTRIM(@Correo)) = '') RETURN -4;

    -- Evitar duplicados (opcional)
    IF EXISTS (SELECT 1 FROM dbo.Vendedores WHERE Cedula = @Cedula OR Correo = @Correo)
        RETURN -1;

    INSERT INTO dbo.Vendedores (Cedula, Nombre, Correo, Estado)
    VALUES (LTRIM(RTRIM(@Cedula)), LTRIM(RTRIM(@Nombre)), LTRIM(RTRIM(@Correo)), 1);

    RETURN 1;
END

GO
