# tudo ok com os dados na limpeza

SELECT * FROM olist.olist_order_payments LIMIT 5;
describe olist_order_payments;

SELECT sum(payment_value) from olist_order_payments;

#confere se há algum problema com a coluna payment_type
select count(payment_type) as contagem_pag, payment_type from olist_order_payments
group by payment_type;

# order_id verifica se há mais de um linha na tabela. Não pode ser primary key.
select order_id, count(order_id) as num from olist_order_payments
group by order_id
having num > 1;

#verificar se há valores negativos
select payment_value from olist_order_payments
where payment_value < 0;

select payment_sequential from olist_order_payments
group by payment_sequential;

#alterar tipos primitivos
alter table olist_order_payments
modify column payment_sequential tinyint,
modify column order_id varchar(40),
modify column payment_installments tinyint,
modify column payment_type varchar(12),
modify column payment_value decimal(10,2);

#transforma em chaves primárias 
alter table olist_order_payments
add primary key (order_id, payment_sequential);

alter table olist_order_payments
add foreign key (order_id)
references olist_orders(order_id);

# confere se há repetições utilizando 2 colunas combinadas como verificação
SELECT order_id, payment_sequential, COUNT(*) FROM olist_order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

select max(length(payment_installments)) from olist_order_payments;

