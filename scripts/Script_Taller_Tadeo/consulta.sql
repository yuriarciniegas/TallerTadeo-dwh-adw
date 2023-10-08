select 
Location_name,
linetotal,
count_Ventas,
c.category_name
 from adw_TD_datawh.fact_ventas as a 
 inner join adw_TD_datawh.dim_Store as b on a.location_key = b.location_key
 inner join adw_TD_datawh.dim_category as c on c.category_key = a.category_key
limit 5;