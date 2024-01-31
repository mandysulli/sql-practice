select s.cdc_id, count(*) from disc_denorm_specimen s
inner join disc_denorm_isolate i using (cdc_id)
group by s.cdc_id
having count(*) > 1