WITH all_movement AS (
  SELECT
    region, 
    SUBSTR(bill_date, 1, 7) AS event_date, 
    -SUM(amount) AS amt
  FROM cloud_costs
  GROUP BY region, event_date
  UNION ALL
  SELECT
    region, 
    period AS event_date, 
    SUM(amount) AS amt
  FROM cost_allocs
  GROUP BY region, event_date
),
net_movement AS (
  SELECT
    region, event_date,
    SUM(amt) AS amt
  FROM all_movement
  GROUP BY region, event_date
)

SELECT
  region, event_date, amt,
  SUM(amt) 
    OVER (PARTITION BY region ORDER BY event_date
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) 
    AS balance_after_movement
FROM net_movement
ORDER BY region, event_date;
