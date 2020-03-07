using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$primaryKey = ConvertTo-SecureString -String $env:cDBConnectionString -AsPlainText -Force


$cosmosDbContext = New-CosmosDbContext -Emulator -Database $env:cDBDatabase -URI 'myemulator.local' -Key $primaryKey
# $cosmosDbContext = New-CosmosDbContext -Account $env:cDBAccount -Database $env:cDBDatabase -Key $primaryKey

$docQuery = "SELECT * FROM c"

$ResponseHeader = $null
$documents = Get-CosmosDbDocument -Context $cosmosDbContext -CollectionId 'member' -MaxItemCount 5 -ResponseHeader ([ref] $ResponseHeader) -Query $docQuery
$continuationToken = [String] $ResponseHeader.'x-ms-continuation'

foreach($doc in $documents){

    Write-Output "Doc: "
    Write-Output $doc


}


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
