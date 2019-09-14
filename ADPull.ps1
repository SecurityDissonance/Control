#date filter commented out needs work, imported data needs to be recent and clean
# need to check for non-blanks


#gets today's date
$date = Get-Date 

#gets earlier date to compare against
$olddate  = (Get-date).AddDays(-6)

#enables MDBC Modules (need to have MDBC installed)
Import-Module mdbc

#connects to local DB (whould have username password and can be done remotely)
Connect-Mdbc . Assets Managed

$adcomputers = Get-ADComputer -Filter {lastlogondate -gt $olddate } -Properties name,lastlogondate,operatingsystem,Enabled,IPv4Address,IPv6Address,LastBadPasswordAttempt,Name,OperatingSystem,OperatingSystemHotfix,OperatingSystemServicePack,OperatingSystemVersion,SID,CN,Created,CanonicalName,BadLogonCount

Foreach ($data in $adcomputers) {

$asset = $data.name



#normalizes always uppercase
$asset = $asset.ToUpper()

#normalizes qualified names
$asset = $asset.split(".")[0]

$asset = $asset.trim()

#does the item exist
$compare = Get-MdbcData (New-MdbcQuery Asset -eq $asset)

#check if matches and updates relevant entries
if ($asset -eq $compare.Asset) {
if ($data.os -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$inputos = $data.operatingsystem})}
if ($data.ip -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputIP = $data.IPv4Address})}
if ($data.junk1 -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputLocation = $data.LastBadPasswordAttempt})}
if ($data.purpose -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDescription = $data.os})}
if ($data.User -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputUser = $data.User})}
if ($data.Domain -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDomain = $data.Domain})}
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputControl = $date})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputData = $data})
$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{LastUpdated = $date})
  
} else 

#creates new entry

{ 
@{Asset=$asset} | Add-MdbcData 
#does the item exist

$compare = Get-MdbcData (New-MdbcQuery Asset -eq $asset)

if ($asset -eq $compare.Asset)
 {
if ($data.os -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$inputos = $data.operatingsystem})}
if ($data.ip -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputIP = $data.IPv4Address})}
if ($data.junk1 -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputLocation = $data.LastBadPasswordAttempt})}
if ($data.purpose -ne $null) {$compare._id | Update-MdbcData (New-MdbcUpdate -Set @{$InputDescription = $data.os})}
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

