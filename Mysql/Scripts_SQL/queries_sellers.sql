#corresções a serem feitas nas cidades - python

SELECT * FROM olist.olist_sellers;

alter table olist_sellers
modify column seller_id varchar(40),
modify column seller_zip_code_prefix varchar(8),
modify column seller_city varchar(50),
modify column seller_state char(3);

alter table olist_sellers
add primary key (seller_id);

describe olist_sellers;

#primary key
select seller_id, count(seller_id) as num from olist_sellers
group by seller_id
order by seller_id desc;
#having num > 1;

select seller_state from olist_sellers
group by seller_state;