CREATE TRIGGER tr_Vehiculos_Max2PorMarca
ON dbo.Vehiculos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica para cada marca insertada si ya hay más de 2 en total
    IF EXISTS (
        SELECT 1
        FROM dbo.Vehiculos v
        JOIN inserted i ON i.Marca = v.Marca
        GROUP BY v.Marca
        HAVING COUNT(*) > 2
    )
    BEGIN
        RAISERROR('No se pueden registrar más de 2 vehículos de la misma marca.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO