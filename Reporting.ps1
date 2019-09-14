
#gets today's date
$date = Get-Date 

#gets earlier date to compare against
$olddate  = (Get-date).AddDays(-6)

#enables MDBC Modules (need to have MDBC installed)
Import-Module mdbc

Connect-Mdbc . Assets Managed

$mike = Get-MdbcData  (New-MdbcQuery -And (New-MdbcQuery LastUpdated -gt $olddate), (New-MdbcQuery Control.EPO -Exists:$false) )


$mike.Asset

