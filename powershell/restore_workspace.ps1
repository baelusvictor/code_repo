
#1. From PowerShell, login to Power BI Service with an Admin account

Login-PowerBI

#2. Get the list of all deleted workspaces as a Power BI Admin so you can identify the ids, the id is required to restore the Workspace.

Get-PowerBIWorkspace -scope Organization -Deleted

Restore-PowerBIWorkspace -Id “b7410fbc-f3c3-404f-a90c-d6159a9498cb”-RestoredName “premium test” -AdminEmailAddress "victor.baelus@vrt.be"