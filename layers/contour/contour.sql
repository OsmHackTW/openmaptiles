CREATE OR REPLACE VIEW contour_z9 AS (
    SELECT ST_Simplify(geom, 500) AS geometry, height
    FROM contour
    WHERE height::int % 500 = 0
);

CREATE OR REPLACE VIEW contour_z10 AS (
    SELECT ST_Simplify(geom, 200) AS geometry, height
    FROM contour
    WHERE height::int % 200 = 0
);

CREATE OR REPLACE VIEW contour_z11 AS (
    SELECT ST_Simplify(geom, 100) AS geometry, height
    FROM contour
    WHERE height::int % 100 = 0
);

CREATE OR REPLACE VIEW contour_z12 AS (
    SELECT ST_Simplify(geom, 50) AS geometry, height
    FROM contour
    WHERE height::int % 50 = 0
);

CREATE OR REPLACE VIEW contour_z13 AS (
    SELECT ST_Simplify(geom, 20) AS geometry, height
    FROM contour
    WHERE height::int % 20 = 0
);

CREATE OR REPLACE VIEW contour_z14 AS (
    SELECT geom AS geometry, height
    FROM contour
    WHERE height::int % 10 = 0
);

CREATE OR REPLACE FUNCTION layer_contour (bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, height int) AS $$
    SELECT geometry, height::int AS height FROM (
        SELECT * FROM contour_z10 WHERE geometry && bbox AND zoom_level = 10
        UNION ALL
        SELECT * FROM contour_z11 WHERE geometry && bbox AND zoom_level = 11
        UNION ALL
        SELECT * FROM contour_z12 WHERE geometry && bbox AND zoom_level = 12
        UNION ALL
        SELECT * FROM contour_z13 WHERE geometry && bbox AND zoom_level = 13
        UNION ALL
        SELECT * FROM contour_z14 WHERE geometry && bbox AND zoom_level > 14
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
