SELECT order_id, SUM(amount) as total_amount
FROM {{ref('stg_payments')}}
GROUP BY 1
HAVING NOT total_amount >=0