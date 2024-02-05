  SELECT sample_id,
          gene,
          appx_median(depth)
   FROM coverage
   WHERE sample_id like "3004157422%v1"
     AND gene like "%HA%"
   GROUP BY sample_id,
            gene;


#Note this is a sample that should have 2 isolates for the one cdc_id, but that's not really working yet...
# something wrong with the join - the null mean that it's not getting joined to anything
#check the sub queries