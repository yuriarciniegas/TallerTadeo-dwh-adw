INSERT INTO adw_TD_datawh.dim_product (
product_id,
category_id,
subcategory_id,
product_Name,
product_color,
product_size,
product_weight,
product_precio
)

SELECT 
p.ProductID,
ps.ProductCategoryID,
ps.ProductSubcategoryID,
p.Name,
p.Color,
p.Size,
p.Weight,
p.ListPrice
FROM adw.Production_Product as p
inner join adw.Production_ProductSubcategory as ps on p.ProductSubcategoryID=ps.ProductSubcategoryID
