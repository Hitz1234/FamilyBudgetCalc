CREATE FUNCTION udf_GetSKUPrice (@ID_SKU INT)
RETURNS DECIMAL (18, 2)
AS
	BEGIN
		DECLARE @Summ numeric (18, 2)
		SELECT @Summ = (SUM(Value))/(SUM(Quantity))
		FROM dbo.Basket
		WHERE ID_SKU = @ID_SKU
		RETURN @Summ
	END