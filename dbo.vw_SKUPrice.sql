CREATE VIEW dbo.vw_SKUPrice AS
	SELECT *, dbo.udf_GetSKUPrice (1) AS Result
	FROM dbo.SKU