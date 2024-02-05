
SELECT combined.cdc_id,
       combined.cuid,
       combined.gene,
       appx_median(depth)
FROM
  (SELECT coalesce(samples.cdc_id, cov.cdc_id) as cdc_id,
          cov.cuid,
          samples.ngs_subtype,
          cov.gene,
          cov.depth
   FROM
     (SELECT s.cdc_id,
             i.ngs_subtype,
             count(i.isolate_id)
      FROM disc_denorm.specimen s
      INNER JOIN disc_denorm.isolate i USING (cdc_id)
      WHERE ngs_subtype like "H1N1%"
        AND i.contract_lab_id IS NULL
      GROUP BY s.cdc_id,
               i.ngs_subtype
      HAVING count(i.isolate_id)=2
      LIMIT 3
      UNION SELECT *
      FROM
        (SELECT s.cdc_id,
                i.ngs_subtype,
                count(i.isolate_id)
         FROM disc_denorm.specimen s
         INNER JOIN disc_denorm.isolate i USING (cdc_id)
         WHERE ngs_subtype like "H3N2%"
           AND i.contract_lab_id IS NULL
         GROUP BY s.cdc_id,
                  i.ngs_subtype
         HAVING count(i.isolate_id) = 2
         LIMIT 2) AS b) AS samples
   INNER JOIN
     (SELECT rtrim(split_part(`sample_id`, "_", 1)) cdc_id,
             rtrim(split_part(`sample_id`, "_", 2)) cuid,
             gene,
             depth
      FROM dsd.coverage
      GROUP BY cdc_id,
               gene,
               cuid,
               depth) AS cov ON samples.cdc_id=cov.cdc_id) AS combined
WHERE gene like "%HA%"
GROUP BY cdc_id,
         cuid,
         gene;
   


