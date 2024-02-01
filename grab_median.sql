SELECt sample_id, gene, depth, `position`
   FROM coverage
   where sample_id like "3004157422%v1" and gene like "%HA%"
   ORDER BY depth


#Note this is a sample that should have 2 isolates for the one cdc_id, but that's not really working yet...