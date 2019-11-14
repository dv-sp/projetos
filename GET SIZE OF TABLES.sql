SELECT 
    T.NAME AS TABLENAME,
    S.NAME AS SCHEMANAME,
    P.ROWS AS ROWCOUNTS,
    SUM(A.TOTAL_PAGES) * 8 AS TOTALSPACEKB, 
    CAST(ROUND(((SUM(A.TOTAL_PAGES) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TOTALSPACEMB,
    SUM(A.USED_PAGES) * 8 AS USEDSPACEKB, 
    CAST(ROUND(((SUM(A.USED_PAGES) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS USEDSPACEMB, 
    (SUM(A.TOTAL_PAGES) - SUM(A.USED_PAGES)) * 8 AS UNUSEDSPACEKB,
    CAST(ROUND(((SUM(A.TOTAL_PAGES) - SUM(A.USED_PAGES)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UNUSEDSPACEMB
FROM 
    SYS.TABLES T
INNER JOIN      
    SYS.INDEXES I ON T.OBJECT_ID = I.OBJECT_ID
INNER JOIN 
    SYS.PARTITIONS P ON I.OBJECT_ID = P.OBJECT_ID AND I.INDEX_ID = P.INDEX_ID
INNER JOIN 
    SYS.ALLOCATION_UNITS A ON P.PARTITION_ID = A.CONTAINER_ID
LEFT OUTER JOIN 
    SYS.SCHEMAS S ON T.SCHEMA_ID = S.SCHEMA_ID
WHERE 
    T.NAME NOT LIKE 'DT%' 
    AND T.IS_MS_SHIPPED = 0
    AND I.OBJECT_ID > 255 
GROUP BY 
    T.NAME, S.NAME, P.ROWS
ORDER BY 
    T.NAME