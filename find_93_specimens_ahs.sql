SELECT disc_denorm_specimen.specimen_disc_id,
  count(disc_denorm_isolate.isolate_id)
FROM disc_denorm_isolate
left outer JOIN disc_denorm_specimen on disc_denorm_isolate.cdc_id = disc_denorm_specimen.cdc_id
  GROUP BY disc_denorm_specimen.specimen_disc_id
  HAVING count(isolate_id) >1
