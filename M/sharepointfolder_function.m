let
    // always use this script to avoid dynamic source errors when setting the refresh in the service (in PBIX you wel get no error, in the service you will)
    // goal is to extract al files in a sharepoint folder using a function
    Folder = "https://rto365.sharepoint.com/sites/PowerBiFin/Gedeelde documenten/General/PowerBi/Data Files/Refresh/",
    Source = SharePoint.Files("https://rto365.sharepoint.com/sites/PowerBiFin/", [ApiVersion = 15]),
    Filter_row = Table.SelectRows(Source, each ([Folder Path] = Folder)),
    Filter_folder = Filter_row{[Name=#"parameter csv Refresh",#"Folder Path"=Folder]}[Content], // first make a parameter with the name of a particular file + extention in the folder: fe "2022_03_20.csv"
    Import_csv = Csv.Document(Filter_folder,[Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]), // change delimiter if needed
    Promote_header = Table.PromoteHeaders(Import_csv, [PromoteAllScalars=true]) // from here on standard pq
in
    Promote_header