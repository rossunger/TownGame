extends Resource
class_name job

export var jobTitle = ""
export (Enums.IncomeBrackets) var salary
export (Resource) var jobBrain
export var employer = ""
export var multiLocation = false
export var dealWithClients = false
export var goesToClient =false

"""
1. a job is just a series of actions.

types of job sequences:
	- go to job and work in one location. no clients. (e.g. accountant, cook, programmer)
	- go to job and work in a series of locations. no clients (e.g. janitor, postal worker)
	- go to job and work in one location and clients come to you (e.g. therapist, retailer)
	- go to job and work in a series of locations and clients come to you (e.g. doctor/nurse, server)
	- go to clients and do job (e.g. landscaping, journalists, )
	 
	
_OneLocationNoClients
_MultiLocationNoClients
_OneLocationClients
_MultiLocationClients
_OnSite

e.g. retail:
	- talk to customers (and answer phones)
	- process transactions
	- restock supplies
	
e.g. food
	- take orders
	- make food
	- serve food
	- process payments
	- banter with customers?
	
e.g. accountant
	- talk to clients
	- work at desk

e.g. construction, maintenance, landscaping, 
	- talk to client (or employer)
	- get supplies
	- build/fix the thing
	- get paid
	
e.g. 


	Arts and Culture
creators
performers
technicians
Journalists
	
	Health and Wellness
doctors, dentists, nurses, therapists
pharmacists
healers
	
	Business and Finance
accountants, bankers/investors
business owners/managers
PR and marketing
	
	Agriculture
fisher, farmer
market staff
	
	Government and Infrastructure
councillors and support staff
government departments
postal service, Transport
military
Garbage/recycling person

	Science and Technology
Researchers
Engineers, architects
Programmers’
VLT technician
HVAC 
Plumbers, Carpenters, Laborers
	
	Service and Sales
cooks, servers
clerks, reception, personal assistants
telemarketers
retail staff
hair and nails? 
Janitor/Custodian


"""
