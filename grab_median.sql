SELECT  appx_median(b.depth)
       
FROM
  (SELECT sample_id,
          gene,
          depth,
          `position`
   FROM coverage
   WHERE sample_id like "3004157422%v1"
     AND gene like "%HA%"
   GROUP BY sample_id,
            gene,
            depth,
            `position`
            ORDER BY depth) as b


#Note this is a sample that should have 2 isolates for the one cdc_id, but that's not really working yet...