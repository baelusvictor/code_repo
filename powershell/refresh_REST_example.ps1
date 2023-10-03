Login-PowerBI

#audit logs example hardcoded
$dataset = "9fb4ee53-334b-4880-ac5b-0d420e4ab6e3"

#refreshes the specified dataset
$refresh = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method POST -Body ("9fb4ee53-334b-4880-ac5b-0d420e4ab6e3")

#logs the metadata concerning the specified dataset
$refreshlog = Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/datasets/$dataset/refreshes" -Method GET -Body ($dataset) #| ConvertFrom-Json

$refresh
$refreshlog