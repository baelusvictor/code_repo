var filelocatie = @"C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\";
//C:\Users\baeluvi\OneDrive - Cronos\projecten\VRT\matrixbus\
//"C:\Users\baeluvi\OneDrive - Cronos\Bureaublad\"
// zorg wel dat je model een naam heeft: model > description
var filenaam = Model.Description;
var plaats = filelocatie + filenaam + ".tsv.txt";

var importPath = @plaats;
var tsv = ReadFile(importPath);
ImportProperties(tsv);