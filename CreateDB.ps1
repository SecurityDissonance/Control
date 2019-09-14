#will create a database and collection as well as a fake record :)

Import-Module mdbc

# Connect the new collection test.test
Connect-Mdbc . Assets Managed -NewCollection

# Add some test data
@{Asset="TestSystem"} | Add-MdbcData
