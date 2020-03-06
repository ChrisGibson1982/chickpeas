using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$primaryKey = ConvertTo-SecureString -String $env:cDBConnectionString -AsPlainText -Force

$cosmosDbContext = New-CosmosDbContext -Account $env:cDBAccount -Database $env:cDBDatabase -Key $primaryKey




# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
