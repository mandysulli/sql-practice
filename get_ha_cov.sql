SELECT coalesce(samples.cdc_id,cov.cdc_id),
       samples.ngs_subtype,
       cov.gene,
       samples.isolate_id
FROM
  (SELECT s.cdc_id,
          i.ngs_subtype,
          i.isolate_id,
          count(*)
   FROM disc_denorm.specimen s
   INNER JOIN disc_denorm.isolate i USING (cdc_id)
   WHERE ngs_subtype like "H1N1%" and i.contract_lab_id is Null
   GROUP BY s.cdc_id,
            i.ngs_subtype,
            i.isolate_id
   HAVING count(*)=2
   LIMIT 3
   UNION SELECT *
   FROM
     (SELECT s.cdc_id,
             i.ngs_subtype,
             i.isolate_id,
             count(*)
      FROM disc_denorm.specimen s
      INNER JOIN disc_denorm.isolate i USING (cdc_id)
      WHERE ngs_subtype like "H3N2%" and i.contract_lab_id is NULL
      GROUP BY s.cdc_id,
               i.ngs_subtype,
               i.isolate_id
      HAVING count(*) = 2
      LIMIT 2) AS b) AS samples
full outer JOIN
  (SELECT rtrim(split_part(`sample_id`, "_", 1)) cdc_id,
  cast(rtrim(split_part(`sample_id`, "_", 2)) as INT) as isolate_id,
          gene
   FROM dsd.coverage
   group by cdc_id,gene,isolate_id) as cov ON samples.cdc_id=cov.cdc_id and samples.isolate_id=cov.isolate_id;
   