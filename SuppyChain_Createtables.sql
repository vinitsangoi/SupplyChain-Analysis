
--- Table 1 orderlist
CREATE TABLE orderlist 
(	
	Order_Date  			Date,
	Order_ID 				decimal,
	Product_ID				int,
	Customer				varchar(50),
	Unit_quantity			int,
	Weight					decimal,
	Ship_ahead_day_count	int,
	Ship_Late_Day_count		int,
	Origin_Port				varchar(50),	
	Destination_Port		varchar(50),
	Carrier					varchar(50),
	Plant_Code				varchar(50),
	TPT						int,
	Service_Level 			varchar(50)		
)


COPY orderlist FROM 'C:\Program Files\PostgreSQL\14\Datasets\Orderlist - OrderList.csv' CSV Header

SELECT * FROM orderlist

--- Table 2 plantports
CREATE TABLE plantports
(
Plant_Code 	varchar(50),
Port		varchar(50)
)

COPY plantports FROM 'C:\Program Files\PostgreSQL\14\Datasets\Plantports - PlantPorts.csv' CSV Header


--- Table 3 productsperplant
CREATE TABLE productsperplant
(
Plant_Code	varchar(50),
Product_ID	int
)

COPY productsperplant FROM 'C:\Program Files\PostgreSQL\14\Datasets\Productsperplant - ProductsPerPlant.csv' CSV Header


--- Table 4 whcapacities
CREATE TABLE whcapacities
(
Plant_ID 		varchar(50),
Daily_Capacity 	int
)

COPY whcapacities FROM 'C:\Program Files\PostgreSQL\14\Datasets\Whcapacities - WhCapacities.csv' CSV Header


--- Table 5 whcosts
CREATE TABLE whcosts
(
WH			varchar(50),
Cost_unit	decimal
)

COPY whcosts FROM 'C:\Program Files\PostgreSQL\14\Datasets\Whcosts - WhCosts.csv' CSV Header

SELECT * FROM whcosts


--- Table 6 vmicustomers
CREATE TABLE vmicustomers
(
Plant_Code	varchar(50),
Customers	varchar(50)
)

COPY vmicustomers FROM 'C:\Program Files\PostgreSQL\14\Datasets\Vmicustomers - VmiCustomers.csv' CSV Header

SELECT * FROM vmicustomers


-- Table 7 freightrates
Create TABLE freightrates
(
Carrier			varchar(50),
orig_port_cd	varchar(50),
dest_port_cd	varchar(50),
minm_wgh_qty	decimal,
max_wgh_qty		decimal,
svc_cd			varchar(50),
minimum_cost	decimal,
rate			decimal,
mode_dsc		varchar(50),
tpt_day_cnt		int,
Carrier_type	varchar(50)
)


COPY freightrates FROM 'C:\Program Files\PostgreSQL\14\Datasets\freight_rates - FreightRates.csv' CSV Header

SELECT * FROM freightrates









