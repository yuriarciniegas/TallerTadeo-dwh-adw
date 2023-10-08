
INSERT INTO adw_TD_datawh.dim_Store (
    location_id,
    Location_name
)
SELECT 
BusinessEntityID,
Name as Nombre
FROM adw.Sales_Store;
