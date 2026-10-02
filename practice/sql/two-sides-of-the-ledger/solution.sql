with all_mov as(
select region,SUBSTR(bill_date, 1, 7) event_date,
-sum(amount) amt from cloud_costs cc
group by region,event_date
union all
select region,period event_date,sum(amount) amt
from cost_allocs ca
group by region,event_date
),
cur_mov as(
SELECT
    region, event_date,
    SUM(amt) AS amt
      FROM all_mov
 GROUP BY region, event_date
 )
 select region, event_date, amt,
 sum(amt) 
 over (partition by region order by event_date) running_balance
     from cur_mov
     order by region,event_Date;






/*
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
    region, event_date, sum(amt),
    SUM(amt) AS amt
    OVER (PARTITION BY region ORDER BY event_date) roll_sum
  FROM all_movement
 -- GROUP BY region, event_date
)
  select * from net_movement;
  /*
  

SELECT
  region, event_date, amt,
  SUM(amt) 
    OVER (PARTITION BY region ORDER BY event_date
    --  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) 
    AS balance_after_movement
FROM net_movement
ORDER BY region, event_date;
