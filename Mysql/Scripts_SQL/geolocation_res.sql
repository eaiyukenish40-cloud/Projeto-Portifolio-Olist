create table geolocation_res as
select geolocation_zip_code_prefix AS zip_code,
    AVG(geolocation_lat) AS lat,
    AVG(geolocation_lng) AS lng
FROM geolocation
group by geolocation_zip_code_prefix;

select*from geolocation_res ;
describe geolocation_res;

alter table geolocation_res
modify column zip_code varchar(8);

alter table geolocation_res
add primary key (zip_code);
