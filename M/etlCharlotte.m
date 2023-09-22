= Table.AddColumn(
    #"Removed Other Columns", 
    "CorrectieDatum", 
    each if Text.Contains([Omschrijving], "201901") then "januari" 
    else if Text.Contains([Omschrijving], "201902") then "februari"
    else if Text.Contains([Omschrijving], "201903") then "maart"  
    else if Text.Contains([Omschrijving], "201904") then "april"
    else if Text.Contains([Omschrijving], "201905") then "mei" 
    else if Text.Contains([Omschrijving], "201906") then "juni"
    else if Text.Contains([Omschrijving], "201907") then "juli" 
    else if Text.Contains([Omschrijving], "201908") then "augustus"
    else if Text.Contains([Omschrijving], "201909") then "september" 
    else if Text.Contains([Omschrijving], "201910") then "oktober"
    else if Text.Contains([Omschrijving], "201911") then "november" 
    else if Text.Contains([Omschrijving], "201912") then "december"

    else if Text.Contains([Omschrijving], "202001") then "januari" 
    else if Text.Contains([Omschrijving], "202002") then "februari"
    else if Text.Contains([Omschrijving], "202003") then "maart"  
    else if Text.Contains([Omschrijving], "202004") then "april"
    else if Text.Contains([Omschrijving], "202005") then "mei" 
    else if Text.Contains([Omschrijving], "202006") then "juni"
    else if Text.Contains([Omschrijving], "202007") then "juli" 
    else if Text.Contains([Omschrijving], "202008") then "augustus"
    else if Text.Contains([Omschrijving], "202009") then "september" 
    else if Text.Contains([Omschrijving], "202010") then "oktober"
    else if Text.Contains([Omschrijving], "202011") then "november" 
    else if Text.Contains([Omschrijving], "202012") then "december"

    else if Text.Contains([Omschrijving], "202101") then "januari" 
    else if Text.Contains([Omschrijving], "202102") then "februari"
    else if Text.Contains([Omschrijving], "202103") then "maart"  
    else if Text.Contains([Omschrijving], "202104") then "april"
    else if Text.Contains([Omschrijving], "202105") then "mei" 
    else if Text.Contains([Omschrijving], "202106") then "juni"
    else if Text.Contains([Omschrijving], "202107") then "juli" 
    else if Text.Contains([Omschrijving], "202108") then "augustus"
    else if Text.Contains([Omschrijving], "202109") then "september" 
    else if Text.Contains([Omschrijving], "202110") then "oktober"
    else if Text.Contains([Omschrijving], "202111") then "november" 
    else if Text.Contains([Omschrijving], "202112") then "december"

    else if Text.Contains([Omschrijving], "202201") then "januari" 
    else if Text.Contains([Omschrijving], "202202") then "februari"
    else if Text.Contains([Omschrijving], "202203") then "maart"  
    else if Text.Contains([Omschrijving], "202204") then "april"
    else if Text.Contains([Omschrijving], "202205") then "mei" 
    else if Text.Contains([Omschrijving], "202206") then "juni"
    else if Text.Contains([Omschrijving], "202207") then "juli" 
    else if Text.Contains([Omschrijving], "202208") then "augustus"
    else if Text.Contains([Omschrijving], "202209") then "september" 
    else if Text.Contains([Omschrijving], "202210") then "oktober"
    else if Text.Contains([Omschrijving], "202211") then "november" 
    else if Text.Contains([Omschrijving], "202212") then "december"

    else if Text.Contains([Omschrijving], "202301") then "januari" 
    else if Text.Contains([Omschrijving], "202302") then "februari"
    else if Text.Contains([Omschrijving], "202303") then "maart"  
    else if Text.Contains([Omschrijving], "202304") then "april"
    else if Text.Contains([Omschrijving], "202305") then "mei" 
    else if Text.Contains([Omschrijving], "202306") then "juni"
    else if Text.Contains([Omschrijving], "202307") then "juli" 
    else if Text.Contains([Omschrijving], "202308") then "augustus"
    else if Text.Contains([Omschrijving], "202309") then "september" 
    else if Text.Contains([Omschrijving], "202310") then "oktober"
    else if Text.Contains([Omschrijving], "202311") then "november" 
    else if Text.Contains([Omschrijving], "202312") then "december"

    else if Text.Contains([Omschrijving], "corr") then "december"

    else [boekmaand])

    vorige versie

    let
    Source = Excel.CurrentWorkbook(){[Name="Tabel1"]}[Content],
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Onderdeel", type text}, {"Extra onderdeel", type text}, {"Kostenplaats", type text}, {"Objectomschrijving", type text}, {"Pijler", type text}, {"Detail", type text}, {"Kostensoort", type text}, {"Naam v. kostensoort", type text}, {"Wrd./versl.val.", type number}, {"Boekjaar", Int64.Type}, {"Omschrijving", type text}, {"Order", type text}, {"Boekingsdatum", type datetime}, {"Kolom1", type logical}, {"periode correct", type text}, {"Boekmaand", type text}, {"Nr. referentiedoc.", Int64.Type}, {"Referentiecode 3", type text}, {"Finale Leverancier", type text}, {"Documentsoort", Int64.Type}, {"Documentnummer", Int64.Type}, {"Gebruikersnaam", type text}, {"Ingevoerd op", type datetime}, {"Finale Leverancier Omschrijving", type text}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"Boekingsdatum", "periode correct", "Boekmaand", "Omschrijving"}),
    #"Inserted Last 6 Characters" = Table.AddColumn(#"Removed Other Columns", "Last 6 Characters", each Text.End([Omschrijving], 6), type text),
    #"Inserted First 4 Characters" = Table.AddColumn(#"Inserted Last 6 Characters", "First 4 Characters", each Text.Start([Last 6 Characters], 4), type text),
    #"Inserted Last 2 Characters" = Table.AddColumn(#"Inserted First 4 Characters", "Last 2 Characters", each Text.End([Last 6 Characters], 2), type text),
    #"Add monthcolumn" = Table.AddColumn(#"Inserted Last 2 Characters", "number to month", each if [Last 2 Characters] = "01" then "januari" else if [Last 2 Characters] = "02" then "februari" else if [Last 2 Characters] = "03" then "maart" else if [Last 2 Characters] = "04" then "april" else if [Last 2 Characters] = "05" then "mei" else if [Last 2 Characters] = "06" then "juni" else if [Last 2 Characters] = "07" then "juli" else if [Last 2 Characters] = "08" then "augustus" else if [Last 2 Characters] = "09" then "september" else if [Last 2 Characters] = "10" then "oktober" else if [Last 2 Characters] = "11" then "november" else if [Last 2 Characters] = "12" then "december" else if Text.Contains([Omschrijving], "corr") then "december" else "ERR"),
    #"Add check jaar" = Table.AddColumn(#"Add monthcolumn", "check jaar", each if [First 4 Characters] = "2019" then true else if [First 4 Characters] = "2020" then true else if [First 4 Characters] = "2021" then true else if [First 4 Characters] = "2022" then true else false),
    #"Add check maand" = Table.AddColumn(#"Add check jaar", "check maand", each if [Last 2 Characters] = "01" then true else if [Last 2 Characters] = "02" then true else if [Last 2 Characters] = "03" then true else if [Last 2 Characters] = "04" then true else if [Last 2 Characters] = "05" then true else if [Last 2 Characters] = "06" then true else if [Last 2 Characters] = "07" then true else if [Last 2 Characters] = "08" then true else if [Last 2 Characters] = "09" then true else if [Last 2 Characters] = "10" then true else if [Last 2 Characters] = "11" then true else if [Last 2 Characters] = "12" then true else false),
    #"Add check corr" = Table.AddColumn(#"Add check maand", "check corr", each if Text.Contains([Omschrijving], "corr") then true else false),
    #"Correctie datum" = Table.AddColumn(#"Add check corr", "check final", each if [check jaar] = true and [check maand] = true or [check corr] = true then true else false),
    #"Add Maand_correctie" = Table.AddColumn(#"Correctie datum", "Maand_correctie", each if [check final] = true then [number to month] else [Boekmaand]),
    #"Add IsCorrectieNodig" = Table.AddColumn(#"Add Maand_correctie", "IsCorrectieNodig", each [Maand_correctie] <> [Boekmaand]),
    #"Add IsZelfdeCharlotte" = Table.AddColumn(#"Add IsCorrectieNodig", "IsZelfdeCharlotte", each [Maand_correctie] = [periode correct]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Add IsZelfdeCharlotte",{{"number to month", type text}, {"Maand_correctie", type text}, {"check final", type logical}, {"check corr", type logical}, {"check maand", type logical}, {"check jaar", type logical}, {"IsCorrectieNodig", type logical}, {"IsZelfdeCharlotte", type logical}})
in
    #"Changed Type1"