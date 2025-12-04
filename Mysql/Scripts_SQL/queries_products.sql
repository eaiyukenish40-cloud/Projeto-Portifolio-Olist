SELECT *  FROM olist.olist_products;
describe olist.olist_products;

#seleciona as top 10 categorias de produtos vendidos
select distinct(op.product_category_name) as categoria, sum(qi.price) as totalprice from olist_products op
join order_items qi on op.product_id = qi.product_id
where op.product_category_name is not null
group by categoria
order by totalprice desc limit 10;

#alterar o tipo primitivo
alter table olist_products
modify column product_id varchar (40),
modify column product_category_name varchar (60),
modify column product_name_lenght tinyint,
modify column product_description_lenght smallint,
modify column product_photos_qty tinyint,
modify column product_weight_g smallint unsigned,
modify column product_length_cm tinyint,
modify column product_height_cm tinyint,
modify column product_width_cm tinyint unsigned;

alter table olist_products
add primary key (product_id);

#correção necessária - rev.01 correções feita no python
select distinct product_category_name from olist_products;

# product id poder ser primary
select product_id, count(product_id) from olist_products
group by product_id
order by product_id desc;

#confere os valores negativos
SELECT product_name_lenght FROM olist.olist_products
group by product_name_lenght
order by product_name_lenght desc;
#having product_name_lenght < 0;

SELECT product_description_lenght FROM olist.olist_products
group by product_description_lenght
order by product_description_lenght desc;
#having product_description_lenght < 0;

SELECT product_photos_qty FROM olist.olist_products
group by product_photos_qty
order by product_photos_qty desc;
#having product_photos_qty < 0;

SELECT product_weight_g FROM olist.olist_products
group by product_weight_g
order by product_weight_g desc;
#having product_weight_g < 0;

SELECT product_length_cm FROM olist.olist_products
group by product_length_cm
order by product_length_cm desc;
# having product_length_cm < 0;

SELECT product_height_cm FROM olist.olist_products
group by product_height_cm
order by product_height_cm desc;
# having product_height_cm < 0;

SELECT product_width_cm FROM olist.olist_products
group by product_width_cm
order by product_width_cm desc;
#having product_width_cm < 0;

