Onderdeel	Niveau1	IsSubtotaal	sort
RESULTATEN 	I. Bedrijfsopbrengsten	FALSE	1
RESULTATEN 	II. Bedrijfskosten	FALSE	2
RESULTATEN 	III. Bedrijfsverlies/winst	TRUE	3
RESULTATEN 	IV. Financiële opbrengsten	FALSE	4
RESULTATEN 	V. Financiële kosten	FALSE	5
RESULTATEN 	VI. Resultaat uit gewone bedrijfsvoering	TRUE	6
RESULTATEN 	VII. Uitzonderlijke opbrengsten	FALSE	7
RESULTATEN 	VIII. Uitzonderlijke kosten	FALSE	8
RESULTATEN 	X. Belastingen op het resultaat	FALSE	9
RESULTATEN 	IX. Resultaat van het boekjaar	TRUE	10
RESULTAATVERWERKING	A. Te bestemmen resultaat	FALSE	11
RESULTAATVERWERKING	B. Onttrekking aan het eigen vermogen	FALSE	12
RESULTAATVERWERKING	C. Toevoeging aan het eigen vermogen	FALSE	13
RESULTAATVERWERKING	D. Over te dragen resultaat	TRUE	14

Je wil linkse tabel omvormen naar rechtse tabel

Dit kan perfect manueel, maar is mooier met M

1 laad tab in
2 filter op subtotaal
3 filter op niet subtotaal
4 join 2 en 3
5 join 1 en 4

Enkel stap 4 is fancy, maar gaat via onderstaande code


let
    Table1 = #table({"Key1"},{{3},{6},{10}}),
    Table2 = #table({"Key2"},{{1},{2},{4},{5},{6},{7},{8},{9}}),
    RelativeMerge = Table.AddColumn(Table1, "RelativeJoin", 
            (Earlier) => Table.SelectRows(Table2, 
                         each [Key2]<Earlier[Key1])),
    #"Expanded RelativeJoin" = Table.ExpandTableColumn(RelativeMerge, "RelativeJoin", {"Key2"}, {"Key2"}),
    #"Sorted Rows" = Table.Sort(#"Expanded RelativeJoin",{{"Key1", Order.Ascending}})
in
    #"Sorted Rows"