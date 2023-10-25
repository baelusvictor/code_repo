Login-PowerBI

#GET https://api.powerbi.com/v1.0/myorg/admin/reports/e4806a61-3001-49a1-a3d1-d7c200d05036/users


#Make a POST request to the following URI:
#https://api.powerbi.com/v1.0/myorg/groups/{workspaceId}/delete

#GET https://api.powerbi.com/v1.0/myorg/datasets https://api.powerbi.com/v1.0/myorg/admin/datasets 
#GET https://api.powerbi.com/v1.0/myorg/admin/capacities/refreshables
$dataset = "9fb4ee53-334b-4880-ac5b-0d420e4ab6e3"
$csvFile = "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\test.json"



$refresh = (Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/admin/capacities/refreshables?$expand=capacity,group" -Method GET -Body ($dataset))
#$refresh | Export-Json -NoTypeInformation -Path $csvFile 

$refresh