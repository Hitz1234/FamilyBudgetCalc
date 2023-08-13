CREATE PROCEDURE usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
    AS
    BEGIN
        DECLARE @FamilyID INT
        SET @FamilyID = (
            SELECT ID
            FROM dbo.Family
            WHERE dbo.Family.SurName = @FamilySurName)
        IF @FamilyID IS NOT NULL
            UPDATE dbo.Family
            SET BudgetValue = (
                SELECT SUM (Basket.Value)
                FROM dbo.Basket
                WHERE ID_Family = @FamilyID
            )
            WHERE ID = @FamilyID
        ELSE
        PRINT 'Invalide SurName ' + @FamilySurName
    END