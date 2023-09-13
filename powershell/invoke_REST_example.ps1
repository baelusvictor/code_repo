Login-PowerBI

#GET https://api.powerbi.com/v1.0/myorg/admin/reports/e4806a61-3001-49a1-a3d1-d7c200d05036/users


#Make a POST request to the following URI:
#https://api.powerbi.com/v1.0/myorg/groups/{workspaceId}/delete

Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/groups/me/delete" -Method POST
