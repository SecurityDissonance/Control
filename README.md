# Control
Creating a list of existing assets in your enviroment/

# Purpose
Asset management is a critical security control. The design of this program is to get you to level 3 in short order. The work required will be gathering your security and other Business data/

Levels

*	Stage 0: Nothing, very little knowledge about what you have an what is managed
*	Stage 1: Lists - normally  excel spreadsheets, incomplete, out of date and non-standardized
*	Stage 2: CMDB Manually updated, better functionality and data, but still out of data, some standardization forced/
*	Stage 3: Data Driven collection, more accurate information, a level of confidence in the data, not real time, lagged/
*	Stage 4: Data Driven Real time, Asset and control tracking in real time normally done in a SIEM/
*	Stage 5: NAC, security driven connectivity, forced compliance and inspection on devices before connectivity is allowed/
*	Stage 6: NAC + WIDS + Device 
	
Data is broken up into two classes

TRUSTED
Data driven sources, machines talk to these tools and the data is recorded/


UNTRUSTED
Human inputted data, e.g. BIA impacts, lists maintained by others/

Trusted sources can create  asset records and modify update the last updated date
Untrusted sources can only modify record./

The goal is to create a highly trusted list of active devices in your environment and get away from outdated lists filled with things long gone.


https://static.rainfocus.com/splunk/splunkconf18/sess/1523503933784001sLOT/finalPDF/SEC1624_FindAndSeekReal_Final_15385955090140012jBD.pdf

A server or workstation: Windows or Linux are options, this shouldn't be load heavy

# Requirements

Mongo DB
PowerShell
	Active Directory Commandlets
	MDBC PowerShell Module (Github) https://github.com/nightroman/Mdbc (thanks to nightroman for this very useful commandlet)
		Install-Module Mdbc from an admin powershell session
		
	Other (EPOwershell, SQL Server commandlets, etc)
	
Knowledge of datasources in your environment
Defined system based control requirements

Optional 
Optional, but useful is Mongo compass or 3t or another tool to visualize the data, 
Python if you want to recode it and make it run faster

# Steps 

	1. Stand up MongoDB community edition Server. Mongo is fairly easy to set up and start (but please put a username and password on yours 🙂 )
	
		a. Mongo has robust documentation on installation and set up, you just need it up and running, we will create the DBs and Collections Via PowerShell
		https://docs.mongodb.com/manual/administration/install-community/
		
	2. You likely already have Powershell, You will need least Powershell 4 which you should be there already
	
	
	3. Get your data, import it and start reviewing your environment. I will (soon) provide some example sources, AD, EPO, and a script for generic Trusted and Untrusted data
	
	4. Run your scripts at least daily to get fresh information
  
	5. Create reports from the data

# Logic
"Asset" will be the pseudo UUID (Mongos Default UUID will still exist), but for all our purposes we will attempt to match on Asset name. Mongo is case sensitive so your naming convention standards are important

Since MongoDB is a NoSQL DB you can add fields and values at will. But you still want to follow an organization schema to make pulling and comparing data out easier

I would suggest 

Type
OS
IP
Location
Control
Domain

Then I would also include other data on a per source basis. Hopefully you can pick this up from the scripts.

