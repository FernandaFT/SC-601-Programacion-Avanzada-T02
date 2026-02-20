USE [master]
GO

CREATE DATABASE [Practica2]
GO
USE [Practica2]
GO

CREATE TABLE [dbo].[Vehiculos](
	[IdVehiculo] [bigint] IDENTITY(1,1) NOT NULL,
	[Marca] [varchar](100) NOT NULL,
	[Modelo] [varchar](100) NOT NULL,
	[Color] [varchar](100) NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[IdVendedor] [bigint] NOT NULL,
 CONSTRAINT [PK_Vehiculos] PRIMARY KEY CLUSTERED 
(
	[IdVehiculo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Vendedores](
	[IdVendedor] [bigint] IDENTITY(1,1) NOT NULL,
	[Cedula] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Vendedores] PRIMARY KEY CLUSTERED 
(
	[IdVendedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Vehiculos] ON 
GO
INSERT [dbo].[Vehiculos] ([IdVehiculo], [Marca], [Modelo], [Color], [Precio], [IdVendedor]) VALUES (9, N'BMW', N'X5', N'Rojo', CAST(200000.00 AS Decimal(18, 2)), 48)
GO
INSERT [dbo].[Vehiculos] ([IdVehiculo], [Marca], [Modelo], [Color], [Precio], [IdVendedor]) VALUES (10, N'BMW', N'X7', N'Negro', CAST(40000000.00 AS Decimal(18, 2)), 45)
GO
INSERT [dbo].[Vehiculos] ([IdVehiculo], [Marca], [Modelo], [Color], [Precio], [IdVendedor]) VALUES (11, N'Audi', N'M8', N'Verde', CAST(56700000.00 AS Decimal(18, 2)), 51)
GO
INSERT [dbo].[Vehiculos] ([IdVehiculo], [Marca], [Modelo], [Color], [Precio], [IdVendedor]) VALUES (12, N'SS', N'AA', N'AA', CAST(333.00 AS Decimal(18, 2)), 50)
GO
INSERT [dbo].[Vehiculos] ([IdVehiculo], [Marca], [Modelo], [Color], [Precio], [IdVendedor]) VALUES (13, N'Toyota', N'Corolla', N'Blanco', CAST(3400000.00 AS Decimal(18, 2)), 47)
GO
SET IDENTITY_INSERT [dbo].[Vehiculos] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendedores] ON 
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (45, N'116700557', N'Fernanda Fajardo', N'ffajardo@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (46, N'800600076', N'Ana Torres', N'atorres@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (47, N'561233990', N'Flor Silvestre', N'fs@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (48, N'116700558', N'Guadalupe Fajardo', N'gf@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (49, N'562388115', N'Samuel Quesada', N'samu@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (50, N'551175226', N'Monica Q', N'q@gmail.com', 1)
GO
INSERT [dbo].[Vendedores] ([IdVendedor], [Cedula], [Nombre], [Correo], [Estado]) VALUES (51, N'800600056', N'test', N'a@gmail.com', 1)
GO
SET IDENTITY_INSERT [dbo].[Vendedores] OFF
GO
ALTER TABLE [dbo].[Vehiculos]  WITH CHECK ADD  CONSTRAINT [FK_Vehiculos_Vendedores] FOREIGN KEY([IdVendedor])
REFERENCES [dbo].[Vendedores] ([IdVendedor])
GO
ALTER TABLE [dbo].[Vehiculos] CHECK CONSTRAINT [FK_Vehiculos_Vendedores]
GO


CREATE PROCEDURE [dbo].[sp_ExisteCedulaVendedor]
	@Cedula VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

  SELECT CASE WHEN EXISTS (
      SELECT 1 FROM Vendedores WHERE Cedula = @Cedula
  ) THEN 1 ELSE 0 END AS Existe;
END
GO


CREATE PROCEDURE [dbo].[sp_ListarVehiculo]
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

CREATE   PROCEDURE [dbo].[sp_LVendedores]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT IdVendedor, Nombre
	FROM Vendedores
	WHERE Estado = 1
	ORDER BY Nombre;
END
GO

CREATE   PROCEDURE [dbo].[sp_RVehiculo]
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

CREATE   PROCEDURE [dbo].[sp_RVendedor]
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