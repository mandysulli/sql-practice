SELECT coalesce(samples.cdc_id,cov.cdc_id),
       samples.ngs_subtype,
       cov.gene
FROM
  (SELECT s.cdc_id,
          i.ngs_subtype,
          count(*)
   FROM disc_denorm_specimen s
   INNER JOIN disc_denorm_isolate i USING (cdc_id)
   WHERE ngs_subtype like "H1N1%"
   GROUP BY s.cdc_id,
            i.ngs_subtype
   HAVING count(*) =2
   LIMIT 3
   UNION SELECT *
   FROM
     (SELECT s.cdc_id,
             i.ngs_subtype,
             count(*)
      FROM disc_denorm_specimen s
      INNER JOIN disc_denorm_isolate i USING (cdc_id)
      WHERE ngs_subtype like "H3N2%"
      GROUP BY s.cdc_id,
               i.ngs_subtype
      HAVING count(*) =2
      LIMIT 2) AS b) AS samples
inner JOIN
  (SELECT rtrim(split_part(`sample_id`, "_", 1)) cdc_id,
          gene,
          depth,
          `position`
   FROM id_dev_sandbox.coverage
   group by cdc_id,gene, depth,`position`) as cov ON samples.cdc_id=cov.cdc_id

