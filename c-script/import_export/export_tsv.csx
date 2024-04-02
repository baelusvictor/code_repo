var filelocatie = @"C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\";
//"C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\"
//"C:\Users\baeluvi\OneDrive - Cronos\projecten\VRT\matrixbus\"
// zorg wel dat je model een naam heeft: tools > allow all > model > name
// var filenaam = Model.Name;
var filenaam = Model.Description;
var plaats = filelocatie + filenaam + ".tsv.txt";

var objects = new List<TabularNamedObject>();
objects.AddRange(Model.Tables);
objects.AddRange(Model.AllColumns);
//objects.AddRange(Model.AllHierarchies);
//objects.AddRange(Model.AllLevels);
objects.AddRange(Model.AllMeasures);

// standard options: "Name, Description, SourceColumn, Expression, FormatString, DataType"
//"Name, SourceColumn, Description, InPerspective"
//"Name, SourceColumn, Description, InPerspective[$YTD]"
//"Name, TableGroup, Parent, SourceColumn, InPerspective[$YTD], Description, IsHidden"

var tsv = ExportProperties(objects, "Name, TableGroup, Parent, SourceColumn, Description, InPerspective");

    //kies één van de twee opties hier onder:

tsv.Output(); //export to popup dieje kan kopieren naar een excel als je wil

SaveFile(@plaats, tsv);
Info("tsv werd opgeslagen op :" +plaats);

