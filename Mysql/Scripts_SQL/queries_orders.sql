#sem necessidade de usar o python para limpeza

SELECT * FROM olist.olist_orders limit 5;
describe olist_orders;

select distinct(order_status) from olist_orders;

select count(order_id) from olist_orders;

#alterar o tipo primitivo
alter table olist_orders
modify column customer_id varchar (40),
modify column order_id varchar (40),
modify column order_status varchar(15),
modify column order_purchase_timestamp datetime,
modify column order_approved_at datetime,
modify column order_delivered_carrier_date datetime,
modify column order_delivered_customer_date datetime,
modify column order_estimated_delivery_date datetime;

alter table olist_orders
add primary key (order_id);

alter table olist_orders
add foreign key (customer_id)
references clientes(customer_id);

select distinct order_status from olist_orders;

# é possível ser primary key
select order_id, count(order_id) as num from olist_orders
group by order_id
order by order_id desc;
#having num > 0;

# é possível ser primary key
select customer_id, count(customer_id) as num from olist_orders
group by customer_id
having count(customer_id) > 1;

# verificar os tipos de order status
select distinct order_status from olist.olist_orders;

# verififcar se pedido foi entregue ou não
SELECT * FROM olist_orders
WHERE order_delivered_customer_date IS NULL 
  AND order_status IN ('shipped', 'processing', 'invoiced', 'created', 'approved', 'canceled');

select order_delivered_carrier_date, count(order_delivered_carrier_date) as num from olist.olist_orders
where order_delivered_carrier_date = null;