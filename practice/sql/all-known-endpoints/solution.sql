with cte as(
select endpoint from api_calls 
union 
select endpoint from rate_limits 
),
norm as(
    SELECT 
        CASE 
            -- Rule 1: Collapse all nested auth sub-routes into '/api/v1/auth'
            WHEN endpoint LIKE '/api/v1/auth%' THEN '/api/v1/auth'
            
            -- Rule 2: Remove trailing slashes (if any exist)
            WHEN endpoint LIKE '%/' THEN SUBSTR(endpoint, 1, LENGTH(endpoint) - 1)
            
            ELSE endpoint
        END AS endpoint
    FROM cte
)
    select distinct(endpoint) endpoint from norm
