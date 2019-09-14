﻿#date filter commented out needs work, imported data needs to be recent and clean
# need to check for non-blanks


#please set sourcetype USE CAPITAL LETTERS
$source = "EPO"


#gets today's date
$date = Get-Date 

#gets earlier date to compare against
$olddate  = (Get-date).AddDays(-6)

#imports Trusted Test Data
$testdata = import-csv 'C:\Code\testdata\epo.csv'

#enables MDBC Modules (need to have MDBC installed)
Import-Module mdbc

#connects to local DB (whould have username password and can be done remotely)
Connect-Mdbc . Assets sec530



$InputOS = "OS."+$source
$InputIP = "IP."+$source
$InputLocation = "Location."+$source
$InputDescription = "Description."+$source
$InputControl = "Control."+$source
$InputDomain = "Domain."+$source
$InputUser = "User."+$source
$InputData = "Data."+$source

#for each loop to normalize data add new records or modify existing
Foreach ($data in $testdata) {

#normalizes always uppercase
$data.asset = $data.asset.ToUpper()

#normalizes qualified names
$data.asset = $data.asset.split(".")[0]

$data.asset = $data.asset.trim()

#does the item exist
$compare = Get-MdbcData (New-MdbcQuery Asset -eq $data.asset)

#check if matches and updates relevant entries
if ($data.asset -eq $compare.Asset) {
if ($data.os -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$inputos = $data.os})}
if ($data.ip -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputIP = $data.ip})}
if ($data.junk1 -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputLocation = $data.junk1})}
if ($data.purpose -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDescription = $data.purpose})}
if ($data.User -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputUser = $data.User})}
if ($data.Domain -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDomain = $data.Domain})}
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputControl = $date})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputData = $data})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{LastUpdated = $date})
  
} else 

#creates new entry

{ 
@{Asset=$data.asset} | Add-MdbcData 
#does the item exist

$compare = Get-MdbcData (New-MdbcQuery Asset -eq $data.asset)

if ($data.asset -eq $compare.Asset)
 {
if ($data.os -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$inputos = $data.os})}
if ($data.ip -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputIP = $data.ip})}
if ($data.junk1 -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputLocation = $data.junk1})}
if ($data.purpose -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDescription = $data.purpose})}
if ($data.User -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputUser = $data.User})}
if ($data.Domain -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDomain = $data.Domain})}
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputControl = $date})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputData = $data})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{LastUpdated = $date})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{CreateDate = $date})
  }


}

$compare = $null

}


