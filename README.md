# FamilyBudgetCalc

A project that allows you to calculate the amount of all purchases made by a certain person.

A project written in T-SQL that creates three tables (dbo.SKU, dbo.Family, dbo.Basket).

A function has been created that calculates the cost of a transferred product from the dbo.Basket table using the formula (the sum of Value for the transferred SKU / the sum of Quantity for the transferred SKU).

Created a view that returns all product attributes from the dbo.SKU table and a calculated attribute with the cost of one product (using the dbo.udf_GetSKUPrice function). Created procedure input parameter (@FamilySurName varchar(255)) one of the values ​​of the SurName attribute of the dbo.Family table.

The procedure, when called, updates the data in the dbo.Family tables in the BudgetValue field according to the logic ( dbo.Family.BudgetValue - sum(dbo.Basket.Value), where dbo.Basket.Value is the purchase for the family passed to the procedure). When passing a non-existent dbo.Family.SurName, the user is given an error that there is no such family.

A trigger has been created that, when added to the dbo.Basket table, 2 or more records of the same ID_SKU are added at a time, then the value in the DiscountValue field, for this ID_SKU is calculated using the formula Value * 5%, otherwise DiscountValue = 0