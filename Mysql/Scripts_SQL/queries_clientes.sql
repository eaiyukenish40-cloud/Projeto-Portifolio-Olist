#dados da tabela parecem ser integros, sem a necessidade de padronizar campos nulls, ou padronizar correções de estado. Corrigido customer city pelo python

select*from olist.clientes limit 5;

# verifica os tipos primitivos de cada coluna
describe olist.clientes;

#query para conferir duplicatas - unique id é o cliente que comprou, pode fazer compras várias vezes
select count(customer_unique_id) as pessoa, customer_unique_id from olist.clientes
group by customer_unique_id
having count(customer_unique_id) > 1;

# customer ID é a transação da compra do item. Esse é único
select count(customer_id) as compra, customer_id from olist.clientes
group by customer_id
having compra > 1;

# conferencia dos dados da tabela
SELECT distinct customer_state FROM olist.clientes;
SELECT distinct customer_city, customer_state FROM olist.clientes
order by customer_city;

# conferir cidades e estado
SELECT customer_state, customer_city FROM olist.clientes
group by customer_state, customer_city;
SELECT customer_city FROM olist.clientes
group by customer_city;

#confere a quantidade de clientes por cidade:
select count(customer_unique_id) as n_vendas, customer_city from clientes
group by customer_city
order by n_vendas desc, customer_city asc;
# forma 2
SELECT 
    customer_city, 
    COUNT(*) as total_clientes
FROM clientes
GROUP BY customer_city
ORDER BY total_clientes DESC;

alter table clientes 
modify column customer_id varchar(40) not null,
modify column customer_unique_id varchar(40) not null,
modify column customer_zip_code_prefix varchar(8),
modify column customer_city varchar(50),
modify column customer_state char(3);

# definição chave primária
alter table clientes
add primary key (customer_id);

#definição chave secundária
alter table clientes
add foreign key (customer_zip_code_prefix)
references geolocation_res(zip_code);

#verifica as diferenças entre as os zipcodes da tabela cliente e outros
SELECT DISTINCT c.customer_zip_code_prefix
FROM clientes c
WHERE c.customer_zip_code_prefix NOT IN (
    SELECT zip_code FROM geolocation_res
);

# conferir o tamanho do texto
select max(length(customer_id)) from olist.clientes;