CREATE TRIGGER tr_Vendedores_NoCedulaRepetida
ON dbo.Vendedores
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN dbo.Vendedores v 
          ON v.Cedula = i.Cedula
         AND v.IdVendedor <> i.IdVendedor
    )
    BEGIN
        RAISERROR('La cédula del vendedor no se puede repetir.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO