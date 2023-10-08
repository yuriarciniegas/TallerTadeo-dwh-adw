INSERT INTO adw_TD_datawh.dim_category (
    category_id,

    category_name,
    category_last_update
)


SELECT 
ProductCategoryID,
Name as nombre,
ModifiedDate
FROM adw.Production_ProductCategory
;