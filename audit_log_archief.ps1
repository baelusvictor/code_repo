Login-PowerBI

$activities = Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' | ConvertFrom-Json

$activities.Count
$activities[0]



# The first command sets the execution policy for Windows computers and allows scripts to run.
Set-ExecutionPolicy RemoteSigned

# The following command loads the Exchange Online management module.
Import-Module ExchangeOnlineManagement

# Next, you connect using your user principal name. A dialog will prompt you for your 
# password and any multi-factor authentication requirements.
Connect-ExchangeOnline -UserPrincipalName <user@contoso.com>

# Now you can query for Power BI activity. In this example, the results are limited to 
# 1,000, shown as a table, and the "more" command causes output to display one screen at a time. 
Search-UnifiedAuditLog -StartDate 2023-07-25 -EndDate 2023-07-25 -RecordType PowerBIAudit -ResultSize 1000 | Format-Table | More




# The first command sets the execution policy for Windows computers and allows scripts to run.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# The following command loads the Exchange Online management module.
Import-Module ExchangeOnlineManagement

# Next, you connect using your user principal name. A dialog will prompt you for your 
# password and any multi-factor authentication requirements.
Connect-ExchangeOnline -UserPrincipalName victor.baelus@vrt.be

# Now you can query for Power BI activity. In this example, the results are limited to 
# 1,000, shown as a table, and the "more" command causes output to display one screen at a time. 
Search-UnifiedAuditLog -StartDate 09/16/2021 -EndDate 9/23/2021 -RecordType PowerBIAudit -ResultSize 1000 | Format-Table | More



Login-PowerBI
$Current = Get-Date
$Begin = $CurrentDate.AddHours(-12)
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$StartTime = $Begin.ToUniversal().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $CurrentDate.ToUniversal().ToString("yyyy-MM-ddTHH:mm:ss")
$activities = Get-PowerBIActivityEvent -StartDateTime $StartTime
-EndDateTime $EndTime | ConvertFrom-Json | Export-Csv $csvFile

Login-PowerBI
$Current = Get-Date
$Begin = $Date.AddHours(-12)
$dateString = $Date.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$StartTime = $Begin.ToUniversal().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $Current.ToUniversal().ToString("yyyy-MM-ddTHH:mm:ss")
$activities = Get-PowerBIActivityEvent -StartDateTime $StartTime
-EndDateTime $EndTime | ConvertFrom-Json | Export-Csv $csvFile

Login-PowerBI
$CurrentDate = Get-Date
$Begin = $CurrentDate.AddHours(-12)
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$StartTime = $Begin.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $CurrentDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$activities = Get-PowerBIActivityEvent -StartDateTime $StartTime -EndDateTime $EndTime | ConvertFrom-Json | Export-Csv $csvFile

Login-PowerBI
$CurrentDate = Get-Date
$End = $CurrentDate.AddHours(-13)
$Begin = $CurrentDate.AddHours(-20)
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$Begin = $CurrentDate.AddHours(-20)
$StartTime = $Begin.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $End.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$activities = Get-PowerBIActivityEvent -StartDateTime $StartTime -EndDateTime $EndTime | ConvertFrom-Json | Export-Csv $csvFile


$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".json"



Login-PowerBI

$CurrentDate = Get-Date
$Begin = $CurrentDate.AddHours(-8)
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$StartTime = $Begin.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $CurrentDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")

$activities = Get-PowerBIActivityEvent -StartDateTime $StartTime -EndDateTime $EndTime -User victor.baelus@vrt.be

$activities

Login-PowerBI

$CurrentDate = Get-Date
$End = '2023-07-25T23:59:59'
$Begin = '2023-07-25T00:00:00'
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm")
$csvFile = "C:\PowerBIAuditLogs\" + $dateString + ".csv"
$StartTime = $Begin.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
$EndTime = $End.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")

Export-Csv -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv" -NoTypeInformation

Login-PowerBI
$activities = Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User victor.baelus@vrt.be
$activities | ConvertFrom-Json
$activities | Export-Csv -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv" -NoTypeInformation

Login-PowerBI
$activities = Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User victor.baelus@vrt.be
$activities | ConvertTo-Csv
$activities | Export-Csv -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv" -NoTypeInformation


Login-PowerBI
$activities = (Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User victor.baelus@vrt.be -ResultType JsonString |
ConvertFrom-Json) |
Select Id, RecordType|
Export-Csv -NoTypeInformation -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv"

Login-PowerBI
$activities = (Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User victor.baelus@vrt.be -ResultType JsonString |
ConvertFrom-Json) |
Export-Csv -NoTypeInformation -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv"

Login-PowerBI
$activities = (Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User ivo.peeters@vrt.be -ResultType JsonString |
ConvertFrom-Json) |
Select Id, RecordType, CreationTime, Operation, UserKey, UserId, ClientIP |
Export-Csv -NoTypeInformation -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv"

Login-PowerBI
$activities = (Get-PowerBIActivityEvent -StartDateTime '2023-07-15T00:00:00' -EndDateTime '2023-07-15T23:59:59' -User ivo.peeters@vrt.be -ResultType JsonString |
ConvertFrom-Json) |
Select Id, RecordType, CreationTime, Operation, UserKey, UserId, ClientIP |
Export-Csv -NoTypeInformation -Path "C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\PowerBIAuditLog.csv"

Login-PowerBI
$CurrentDate = Get-Date
$End = '2023-07-26T23:59:59'
$Begin = '2023-07-26T00:00:00'
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm_ss")
$csvFile = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\AuditLogs\" + $dateString + ".csv"
$activities = (Get-PowerBIActivityEvent -StartDateTime $Begin -EndDateTime $End -ResultType JsonString |
ConvertFrom-Json) |
Export-Csv -NoTypeInformation -Path $csvFile

Login-PowerBI
$activities = Get-PowerBIActivityEvent -StartDateTime '2023-07-25T00:00:00' -EndDateTime '2023-07-25T23:59:59' -User victor.baelus@vrt.be
$activities | ConvertFrom-Json

Login-PowerBI
$CurrentDate = Get-Date
$End = '2023-07-26T23:59:59'
$Begin = '2023-07-26T00:00:00'
$dateString = $CurrentDate.ToString("yyyy_MM_dd_HH_mm_ss")
$csvFile = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\AuditLogs\" + $dateString + ".csv"
$activities = (Get-PowerBIActivityEvent -StartDateTime $Begin -EndDateTime $End -ResultType JsonString |
ConvertFrom-Json) | 
Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
Export-Csv -NoTypeInformation -Path $csvFile



Login-PowerBI

foreach ($i in 1..14) {
    #bij activatie script wordt huidige datum als input gebruikt, niet inzitten met overlap want duplicaten worden via power query verwijderd en bestanden op zelfde datum overschreven
    #gaat twee weken terug
    $CurrentDate = Get-Date
    $Datum = $CurrentDate.ToString("yyyy-MM-dd")

    #je kan enkel data downloaden van dezelfde dag, werkt enkel met DateTime, vandaar deze onhandige omweg
    $End = $Datum+'T23:59:59'
    $EndTime = [datetime]::ParseExact($End, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
    $EndTimeVar = $EndTime.AddDays(-$i)
    $EndString = $EndTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")

    $Begin = $Datum+'T00:00:00'
    $BeginTime = [datetime]::ParseExact($Begin, "yyyy-MM-ddTHH:mm:ss", [CultureInfo]::InvariantCulture)
    $BeginTimeVar = $BeginTime.AddDays(-$i)
    $StartString = $BeginTimeVar.ToString("yyyy-MM-ddTHH:mm:ss")

    #$dateString = "download"+$CurrentDate.ToString("yyyy_MM_dd_HH_mm_ss")+"_datum"+$BeginTimeVar.ToString("yyyy_MM_dd")
    $dateString = $BeginTimeVar.ToString("yyyy_MM_dd")
    $csvFile = "C:\Users\baeluvi\VRT\DataTeam Financiën - General\PowerBi\Data Files\AuditLogs\" + $dateString + ".csv"

    $activities = (Get-PowerBIActivityEvent -StartDateTime $StartString -EndDateTime $EndString -ResultType JsonString |
    ConvertFrom-Json) | 
    Select Id, RecordType, CreationTime, Operation, OrganizationId, UserType, UserKey, Workload, UserId, ClientIP, UserAgent, Activity, ItemName, WorkSpaceName, DatasetName, ReportName, CapacityId, CapacityName, WorkspaceId, ObjectId, DataflowId, DataflowName, AppName, DataflowAccessTokenRequestParameters, DatasetId, ReportId, IsSuccess, DataflowType, ReportType, RequestId, ActivityId, AppReportId, DistributionMethod, ConsumptionMethod |
    Export-Csv -NoTypeInformation -Path $csvFile
}
