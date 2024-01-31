SELECT rtrim(split_part(`sample_id`, "_", 1)) cdc_id,
          gene,
          depth,
          `position`
   FROM id_dev_sandbox.coverage
   group by cdc_id,gene, depth,`position`
