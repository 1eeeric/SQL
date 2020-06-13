SELECT raw.N, CASE
    WHEN (raw.P IS NULL) THEN 'Root'
    -- The line below looks for rows where the value of N does not exist in the column P
    -- Unfortunately T-SQL does not allow a simple syntax so we need the SELECT 1 convention as a dummy syntax
    WHEN NOT EXISTS (SELECT 1 FROM BST AS mySub1 WHERE raw.N = mySub1.P) THEN 'Leaf'
    ELSE 'Inner' END AS Category
FROM BST AS raw
ORDER BY raw.N;