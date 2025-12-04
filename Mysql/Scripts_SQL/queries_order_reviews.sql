#sem necessidade de usar o python para limpeza

SELECT * FROM olist.olist_order_reviews limit 5;
describe olist_order_reviews;

#alterar o tipo primitivo
alter table olist_order_reviews
modify column review_id varchar (40),
modify column order_id varchar (40),
modify column review_score tinyint,
modify column review_creation_date datetime,
modify column review_answer_timestamp datetime;

alter table olist_order_reviews
add primary key (review_id,order_id);

alter table olist_order_reviews
add foreign key (order_id)
references olist_orders(order_id);

# verifica a quantidade de "duplicatas"
SELECT review_id, order_id, COUNT(*) FROM olist_order_reviews
GROUP BY review_id, order_id;
#HAVING COUNT(*) > 1;

select review_score from olist_order_reviews
group by review_score;


select count(review_comment_title) as contagem_tipo, review_comment_title from olist_order_reviews
group by review_comment_title;

# não poder ser primary key
select order_id, count(order_id) as num from olist_order_reviews
group by order_id
having num > 1;

# não poder ser primary key, tem mais de 1
select review_id, count(review_id) as num from olist_order_reviews
group by review_id
having num > 1;


select review_score,  review_comment_title from olist_order_reviews
where review_score < 4;