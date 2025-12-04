#limpeza já feita
SELECT * FROM olist.geolocation;

SELECT count(geolocation_city) as city_num, geolocation_city FROM olist.geolocation
group by geolocation_city 
order by count(geolocation_city) desc;

SELECT count(geolocation_zip_code_prefix) as city_num, geolocation_zip_code_prefix FROM olist.geolocation
group by geolocation_zip_code_prefix
order by count(geolocation_zip_code_prefix) desc;

describe olist.geolocation;