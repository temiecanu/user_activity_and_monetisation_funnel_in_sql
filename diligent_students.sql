SELECT COUNT(*) AS diligent_students
FROM (
    SELECT st_id
    FROM peas
    WHERE correct = true
    GROUP BY st_id
    HAVING COUNT(*) >= 20
) AS sub;