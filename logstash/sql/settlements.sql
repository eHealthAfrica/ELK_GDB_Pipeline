SELECT
    fc.id, fc.global_id, fc.sa_global_id, fc.timestamp,
    ST_X (ST_Transform (fc.geom, 4326))::float as longitude,
    ST_Y (ST_Transform (fc.geom, 4326))::float as latitude,
    TRIM(fc.name) as "settlement_name",
    TRIM(fc.source) as "source",
    TRIM(fc.category) as "category",
    TRIM(bw.name) as "ward_name",
    TRIM(fc.ward_code) as "ward_code",
    TRIM(bw.code) as "lga_code",
    TRIM(bl.name) as "lga_name",
    TRIM(bl.code) as "state_code",
    TRIM(bs.name) as "state_name"
FROM nigeria_master.settlements fc 
JOIN nigeria_master.wards bw
  ON (fc.ward_code = bw.code)
JOIN nigeria_master.local_government_areas bl
  ON (bw.lga_code = bl.code)
JOIN nigeria_master.states bs
  ON (bl.state_code = bs.code)
WHERE fc.geom IS NOT NULL;