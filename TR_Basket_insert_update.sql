CREATE TRIGGER TR_Basket_insert_update 
ON dbo.Basket INSTEAD OF INSERT
AS
	BEGIN
		DECLARE @ID_SKU INT
		DECLARE @ID_Family INT
		DECLARE @Quantity INT
		DECLARE @Value INT
		DECLARE @DiscountValue INT
	
		DECLARE ID_SKU_CURSOR CURSOR FOR
		SELECT DISTINCT ID_SKU, ID_Family, Quantity, Value, DiscountValue FROM inserted

		OPEN ID_SKU_CURSOR
		FETCH NEXT FROM ID_SKU_CURSOR INTO @ID_SKU, @ID_Family, @Quantity, @Value, @DiscountValue

		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF (SELECT COUNT(*) FROM inserted WHERE ID_SKU = @ID_SKU) >= 2
				BEGIN
					SET @DiscountValue = @Value * 1.05
					INSERT INTO dbo.Basket (ID_SKU, ID_Family, Quantity, Value, DiscountValue)
					VALUES (@ID_SKU, @ID_Family, @Quantity, @Value, @DiscountValue)
					FETCH NEXT FROM ID_SKU_CURSOR INTO @ID_SKU, @ID_Family, @Quantity, @Value, @DiscountValue
				END
				ELSE
				BEGIN
					SET @DiscountValue = 0
					INSERT INTO dbo.Basket (ID_SKU, ID_Family, Quantity, Value, DiscountValue)
					VALUES (@ID_SKU, @ID_Family, @Quantity, @Value, @DiscountValue)
					FETCH NEXT FROM ID_SKU_CURSOR INTO @ID_SKU, @ID_Family, @Quantity, @Value, @DiscountValue
				END
			END
		CLOSE ID_SKU_CURSOR
		DEALLOCATE ID_SKU_CURSOR
	END