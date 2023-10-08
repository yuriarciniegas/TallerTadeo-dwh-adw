-- Inserta los datos en la tabla de hechos
-- a partir de una consulta
INSERT INTO fact_ventas (
    date_key,
    location_key,
    product_key,
    category_key ,
    subcategory_key,
    linetotal,
    count_Ventas
)

WITH datos AS (

SELECT 
st.location_key, 
p.product_key ,
cat.category_key,
sb.subcategory_key,
TO_DAYS(ot.ModifiedDate) AS date_key,
ot.OrderQty * ot.UnitPrice as linetotal,
1 as count_Ventas
from adw.Sales_SalesOrderHeader as s
inner join adw.Sales_Store as sp on s.SalesPersonID=sp.SalesPersonID
inner join dim_Store as st on st.location_id=sp.BusinessEntityID
inner join adw.Sales_SalesOrderDetail as ot on ot.SalesOrderID = s.SalesOrderID
inner join dim_product as p on p.product_id  = ot.ProductID
inner join adw.Production_Product pp on ot.ProductID  = pp.ProductID
inner join dim_subcategory sb on pp.ProductSubcategoryID = sb.subcategory_id
inner join adw.Production_ProductSubcategory ps on pp.ProductSubcategoryID = ps.ProductSubcategoryID
inner join adw.Production_ProductCategory pc on pc.ProductCategoryID = ps.ProductCategoryID 
inner join dim_category cat on cat.category_id  = pc.ProductCategoryID
)

SELECT 
    date_key,
    location_key,
    product_key,
    category_key ,
    subcategory_key,
    SUM(linetotal),
    SUM(count_Ventas)
FROM datos
GROUP BY 
    date_key,
    location_key,
    product_key,
    category_key ,
    subcategory_key
;
