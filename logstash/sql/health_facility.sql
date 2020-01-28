SELECT
    fc.id, fc.global_id, fc.timestamp,
    ST_X (ST_Transform (fc.geom, 4326))::float as longitude,
    ST_Y (ST_Transform (fc.geom, 4326))::float as latitude,
    TRIM(fc.source) as "source",
    TRIM(fc.type) as "hf_type",
    TRIM(fc.name) as "hf_name",
    TRIM(fc.alternate_name) as "alternate_name",
    TRIM(fc.functional_status) as "functional_status",
    TRIM(fc.ownership) as "ownership",
    TRIM(fc.accessibility) as "accessibility",
    TRIM(fc.category) as "category",
    TRIM(fc.ward_code) as "ward_code",
    TRIM(bw.name) as "ward_name",
    TRIM(bl.name) as "lga_name",
    TRIM(bs.name) as "state_name",
    TRIM(bw.lga_code) as "lga_code",
    TRIM(bl.state_code) as "state_code"
FROM nigeria_master.health_facilities fc 
INNER JOIN nigeria_master.wards bw
        ON (bw.code = fc.ward_code)
INNER JOIN nigeria_master.local_government_areas bl
        ON (bl.code = bw.lga_code)
INNER JOIN nigeria_master.states bs
        ON (bs.code = bl.state_code)
WHERE fc.geom IS NOT NULL;