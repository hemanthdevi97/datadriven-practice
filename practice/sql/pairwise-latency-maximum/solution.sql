select 
  format(a.latency,3) latency_1,
  format(b.latency,3) latency_2,
format(greatest(a.latency,b.latency),3) max_latency
 from api_calls a cross join
api_calls b where a.latency<=b.latency
 order by a.latency,b.latency
limit 100;
