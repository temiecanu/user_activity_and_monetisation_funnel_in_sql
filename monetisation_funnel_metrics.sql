WITH
active_students AS (
    SELECT st_id
    FROM peas
    WHERE correct = true
    GROUP BY st_id
    HAVING COUNT(*) > 10

    UNION

    SELECT st_id
    FROM peas
    WHERE correct = true AND subject = 'Math'
    GROUP BY st_id
    HAVING COUNT(*) >= 2
),
active_students_math AS (
    SELECT st_id
    FROM peas
    WHERE correct = true AND subject = 'Math'
    GROUP BY st_id
    HAVING COUNT(*) >= 2
),
active_students_bought_math AS (
    SELECT st_id
    FROM checks
    WHERE subject = 'Math' AND st_id IN (
        SELECT st_id
        FROM active_students_math
    )
),
cte AS (
    SELECT
        c.st_id,
        c.money,
        s.test_grp
    FROM checks AS c
    JOIN studs AS s ON c.st_id = s.st_id
),
total_students AS (
    SELECT COUNT(*) AS cnt FROM studs
),
total_payers AS (
    SELECT COUNT(DISTINCT st_id) AS cnt FROM checks
),
total_active_students AS (
    SELECT COUNT(*) AS cnt FROM active_students
),
total_active_students_math AS (
    SELECT COUNT(*) AS cnt FROM active_students_math
)

SELECT
    test_grp,
    SUM(money) / ts.cnt AS arpu,
    SUM(money) FILTER (WHERE cte.st_id IN (SELECT st_id FROM active_students)) /
    COUNT(DISTINCT CASE WHEN cte.st_id IN (SELECT st_id FROM active_students) THEN cte.st_id END) AS arpau,
    tp.cnt::float / ts.cnt AS cr,
    COUNT(DISTINCT CASE WHEN cte.st_id IN (SELECT st_id FROM active_students) THEN cte.st_id END)::float / tas.cnt AS cra,
    COUNT(DISTINCT CASE WHEN cte.st_id IN (SELECT st_id FROM active_students_bought_math) THEN cte.st_id END)::float / tasm.cnt AS cra_math
FROM cte, total_students ts, total_payers tp, total_active_students tas, total_active_students_math tasm
GROUP BY test_grp, ts.cnt, tp.cnt, tas.cnt, tasm.cnt;