--- Title :-        SupplyChain Analysis
--- Created by :-   Hardi Jain & Vinit Sangoi
--- Date :-         03-10-2022
--- Tool used:-     PostgreSQL

/*
Description :- 
		• This is a SupplyChain SQL Project. This database contains 7 tables retail.
		• Retail table has 9000 rows.
		• In this project, Hardi Jain & Vinit Sangoi worked together.
		
Approach :- 
		• Understanding the dataset
		• Creating business questions
		• Analysing through SQL queries
*/


-- Q1) Count of Top 50 Products which has maximum order
SELECT 	 product_id, count(order_id) as total_orders
FROM 	 orderlist
GROUP BY product_id
ORDER BY total_orders desc
LIMIT 	 50


-- Q2) Sum of quantity ordered by each customer
SELECT 	 customer, 
		 sum(unit_quantity) AS total_quantity
FROM 	 orderlist
GROUP BY customer
ORDER BY total_quantity desc


-- Q3) Origin & destination port of each customer
SELECT 	   distinct(a.customer),            ----- Self join method
		   b.origin_port,
		   b.destination_port,
		   b.plant_code                   
FROM 	   orderlist as a
Inner JOIN orderlist as b
ON a.order_id = b.order_id

SELECT 	 distinct(customer),    ----- Normal 
		 origin_port,
		 destination_port,
		 plant_code   
FROM 	 orderlist 
ORDER BY customer 


-- Q4) List of Customers with respective product ids where the early delivery is more then 3
SELECT 	 customer,
		 product_id, 
		 round(avg(ship_ahead_day_count),0) as avg_delivery
FROM 	 orderlist
GROUP BY customer,product_id
HAVING 	 round(avg(ship_ahead_day_count),0) > 3
ORDER BY customer desc, avg_delivery desc


-- Q5) List the product with total orders & quantity and average weight
SELECT   product_id ,
	     count(product_id) as total_orders,
	     sum(unit_quantity) as total_units, 
	     round(avg(weight),0) as avg_weight
FROM 	 orderlist
GROUP BY product_id
ORDER BY avg_weight desc


-- Q6) List of ports and plants used for customers
SELECT      distinct(a.customer), 
		    b.plant_code, b.port
FROM 	    orderlist as a
Inner Join  plantports as b
ON          a.plant_code = b.plant_code
ORDER BY    a.customer desc


-- Q7) List the plants which are operating at under & over capacity

CREATE VIEW capacity AS 
SELECT 		a.plant_code, 
			count(a.order_id),
			b.daily_capacity, 
			(b.daily_capacity - count(a.order_id)) as diff
FROM     	orderlist as a
INNER JOIN  whcapacities as b
ON     		a.plant_code = b.plant_ID
GROUP BY 	a.plant_code,b.daily_capacity


SELECT 	 *,
		 Case 
		   When diff < 0 Then 'over-capacity'
		   Else 'under-capacity'
		   END condition
FROM 	 capacity
ORDER BY diff



-- Q8) Count of plants which are operating at over-capacity
SELECT 	count(condition)
FROM 	(SELECT *,
			Case 
			When diff < 0 Then 'over-capacity'
			Else 'under-capacity'
			END condition
	 	 FROM capacity
	 	 ORDER BY diff) as sub
WHERE 	condition = 'over-capacity'


-- Q9) Count of plants which are operating at under-capacity
SELECT 	count(condition)
FROM 	(SELECT *,
			Case 
			When diff < 0 Then 'over-capacity'
			Else 'under-capacity'
			END condition
		 FROM capacity
	 	 ORDER BY diff) as sub
WHERE 	condition = 'under-capacity'


-- Q10) Total cost incurred at each plant by every customer
SELECT 		distinct(a.customer),
			sum(a.unit_quantity) as total_quantity, 
			b.plant_code, b.port,
			c.cost_unit,
			sum((a.unit_quantity*c.cost_unit)) as total_cost
FROM 		orderlist as a
Inner Join 	plantports as b
ON 			a.plant_code = b.plant_code
Inner Join 	whcosts as c
ON 			a.plant_code = c.WH
GROUP BY	a.customer,
			b.plant_code, 
			b.port,
			c.cost_unit
ORDER BY 	a.customer desc


-- Q11) Total cost incurred for each product
SELECT 		distinct(a.product_id),
			sum(a.unit_quantity) as total_quantity,
			sum((a.unit_quantity*b.cost_unit)) as total_cost
FROM 		orderlist as a
INNER JOIN 	whcosts as b
ON 			a.plant_code = b.WH
GROUP BY 	distinct(a.product_id)
ORDER BY 	total_cost desc


-- Q12) Show the total cost column in th orderlist table
SELECT 		a.*,
			(a.unit_quantity*b.cost_unit) as total_cost
FROM 		orderlist as a
INNER JOIN 	whcosts as b
ON 			a.plant_code = b.WH


-- Q13) Create table order_list02 with total cost
CREATE TABLE order_list02 as
SELECT 		a.*,
			(a.unit_quantity*b.cost_unit) as total_cost
FROM 		orderlist as a
INNER JOIN 	whcosts as b
ON 			a.plant_code = b.WH

SELECT 	* 
FROM 	order_list02


-- Q14) Query a output representing min & max quantity of origin port and destination port
SELECT		orig_port_cd,
       		dest_port_cd,
	   		sum(minm_wgh_qty) as min_qty,
	   		sum(max_wgh_qty)  as max_qty,
	   		sum(minimum_cost) as min_cost
FROM 		freightrates
GROUP BY 	orig_port_cd,dest_port_cd
ORDER BY 	orig_port_cd,dest_port_cd


-- Q15) Query a output representing min & max quantity of mode type 
SELECT 		mode_dsc,
	   		sum(minm_wgh_qty) as min_qty,
	   		sum(max_wgh_qty)  as max_qty,
	   		sum(minimum_cost) as min_cost
FROM 		freightrates
GROUP BY 	mode_dsc
ORDER BY 	min_cost


--Q16) Find out average transport day count by carrier
SELECT 		carrier,
			round(avg(tpt_day_cnt),2)
FROM 		freightrates
GROUP BY 	carrier
ORDER BY 	carrier
	
	
--Q17) Query total rate by origin port
SELECT 		orig_port_cd,
			sum(rate) as total_rate
FROM 		freightrates
GROUP BY 	orig_port_cd
ORDER BY 	orig_port_cd

