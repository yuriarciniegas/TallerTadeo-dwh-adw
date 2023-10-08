## Creación de Bodega de datos
## ---------------------------

##
## adw_TD_datawh
## -------------
CREATE DATABASE IF NOT EXISTS adw_TD_datawh;
USE adw_TD_datawh;

-- Dimension Tiempo
-- Tabla dim_date
CREATE TABLE IF NOT EXISTS dim_time (

  date_key INT(8) NOT NULL,
  date_value DATE NOT NULL,
  
  month_number TINYINT(3) NOT NULL,
  month_name CHAR(12) NOT NULL,
  year4 SMALLINT(5) NOT NULL,
  year_month_number CHAR(7) NOT NULL,
  
  PRIMARY KEY (date_key),
  UNIQUE INDEX date (date_value) VISIBLE,
  UNIQUE INDEX date_value (`date_value` ASC) VISIBLE
);

-- Dimensión almacen
-- Tabla dim_Store

create table if not exists dim_Store (

    location_key INT(8) NOT NULL AUTO_INCREMENT,
    location_id INT(8) NULL DEFAULT NULL,
    Location_name VARCHAR(90) NULL DEFAULT NULL,
    Location_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

      PRIMARY KEY (location_key),
      UNIQUE INDEX location_id (location_id) VISIBLE

);

-- Dimensión subcategoria
-- Tabla dim_subcategory


create table if not exists dim_subcategory (

    subcategory_key INT(8) NOT NULL AUTO_INCREMENT,
    subcategory_id INT(8) NULL DEFAULT NULL,
    subcategory_name VARCHAR(90) NULL DEFAULT NULL,
    subcategory_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

      PRIMARY KEY (subcategory_key),
      UNIQUE INDEX subcategory_id (subcategory_id) VISIBLE

);

-- Dimensión Categoria
-- Tabla dim_Category

create table if not exists dim_category (

    category_key INT(8) NOT NULL AUTO_INCREMENT,
    category_id INT(8) NULL DEFAULT NULL,
    category_name VARCHAR(90) NULL DEFAULT NULL,
    category_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

      PRIMARY KEY (category_key),
      UNIQUE INDEX category_id (category_id) VISIBLE

);

-- Dimensión Producto
-- Tabla dim_product

create table if not exists dim_product (

    product_key INT(8) NOT NULL AUTO_INCREMENT,
    product_id INT(11) NOT NULL,
    category_id INT(8) NULL DEFAULT NULL,
    subcategory_id INT(8) NULL DEFAULT NULL,
    product_Name NVARCHAR(100) NULL DEFAULT NULL,
    product_color NVARCHAR(100) NULL DEFAULT NULL,
    product_size NVARCHAR(100) NULL DEFAULT NULL,
    product_weight DECIMAL(8,2) NULL DEFAULT NULL,
    product_precio DECIMAL(10,2) NULL DEFAULT NULL,
    product_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

     PRIMARY KEY (product_key),
     UNIQUE INDEX product_id (product_id) VISIBLE

);

-- Hechos ventas
-- Tabla fact_ventas
CREATE TABLE IF NOT EXISTS fact_ventas (
  
  ventas_id INT(11) NULL DEFAULT NULL,

  date_key     	  int(8) not null,
  location_key    INT(8) NOT NULL,
  product_key     INT(8) NOT NULL,
  category_key    INT(8) NOT NULL,
  subcategory_key INT(8)  NOT NULL,

  linetotal INT(10) NOT NULL,
  count_Ventas INT(8) NOT NULL,

  INDEX fk_location_idx (location_key ASC) VISIBLE,
  INDEX fk_product_idx (product_key ASC) VISIBLE,
  INDEX fk_date_idx (date_key ASC) VISIBLE,
  INDEX fk_category_idx (category_key ASC) VISIBLE,
 INDEX fk_subcategory_idx (subcategory_key ASC) VISIBLE,



  CONSTRAINT fk_location
  FOREIGN KEY (location_key)
  REFERENCES dim_Store (location_key)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,

  CONSTRAINT fk_product
  FOREIGN KEY (product_key)
  REFERENCES dim_product (product_key)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,

  CONSTRAINT fk_date
  FOREIGN KEY (date_key)
  REFERENCES dim_time (date_key)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,

  CONSTRAINT fk_category
  FOREIGN KEY (category_key)
  REFERENCES dim_category (category_key)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,

  CONSTRAINT fk_subcategory
  FOREIGN KEY (subcategory_key)
  REFERENCES dim_subcategory (subcategory_key)
  ON DELETE CASCADE
  ON UPDATE NO ACTION
);
