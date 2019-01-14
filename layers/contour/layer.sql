CREATE OR REPLACE FUNCTION nth_line (height int, base int) RETURNS int AS $$
    DECLARE
       num INTEGER := height / base;

    BEGIN
        IF num % 10 = 0 THEN
            RETURN 10;
        ELSEIF num % 5 = 0 THEN
            RETURN 5;
        ELSEIF num % 2 = 0 THEN
            RETURN 2;
        ELSE
            RETURN 1;
        END IF;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW contour_z9 AS (
    SELECT ST_Simplify(geom,500) AS geom, height, nth_line(height::int, 500) AS nth_line
    FROM contour
    WHERE height::int % 500 = 0
);

CREATE OR REPLACE VIEW contour_z10 AS (
    SELECT ST_Simplify(geom,200) AS geom, height, nth_line(height::int, 200) AS nth_line
    FROM contour
    WHERE height::int % 200 = 0
);

CREATE OR REPLACE VIEW contour_z11 AS (
    SELECT ST_Simplify(geom,100) AS geom, height, nth_line(height::int, 100) AS nth_line
    FROM contour
    WHERE height::int % 100 = 0
);

CREATE OR REPLACE VIEW contour_z12 AS (
    SELECT ST_Simplify(geom,50) AS geom, height, nth_line(height::int, 50) AS nth_line
    FROM contour
    WHERE height::int % 50 = 0
);

CREATE OR REPLACE VIEW contour_z13 AS (
    SELECT ST_Simplify(geom,20) AS geom, height, nth_line(height::int, 20) AS nth_line
    FROM contour
    WHERE height::int % 20 = 0
);

CREATE OR REPLACE VIEW contour_z14 AS (
    SELECT geom AS geom, height, nth_line(height::int, 10) AS nth_line
    FROM contour
);

CREATE OR REPLACE FUNCTION layer_contour (bbox geometry, zoom_level int)
RETURNS TABLE(geom geometry, height int, nth_line int) AS $$
    SELECT geom, height::int, nth_line::int FROM (
        SELECT * FROM contour_z10 WHERE geom && bbox AND zoom_level = 10
        UNION ALL
        SELECT * FROM contour_z11 WHERE geom && bbox AND zoom_level = 11
        UNION ALL
        SELECT * FROM contour_z12 WHERE geom && bbox AND zoom_level = 12
        UNION ALL
        SELECT * FROM contour_z13 WHERE geom && bbox AND zoom_level = 13
        UNION ALL
        SELECT * FROM contour_z14 WHERE geom && bbox AND zoom_level > 14
    ) AS zoom_levels;
$$ LANGUAGE SQL IMMUTABLE;
