var filelocatie = @"C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\";
var filenaam = @"export"; //Model.Description;
var plaats = filelocatie + filenaam + ".tsv.txt";

var objects = new List<TabularNamedObject>();
//objects.AddRange(Model.Tables); //changing a tables metadata trough this macro is sometimes bugged :(
objects.AddRange(Model.AllColumns);
objects.AddRange(Model.AllMeasures);

var tsv = ExportProperties(objects, "Name, TableGroup, Parent, SourceColumn, Description, InPerspective, IsHidden");

tsv.Output(); //export to popup dieje kan kopieren naar een excel als je wil

SaveFile(@plaats, tsv);
Info("tsv werd opgeslagen op :" +plaats);