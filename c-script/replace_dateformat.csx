foreach(var t in Model.AllColumns) {
    if(t.DataType.ToString() == "DateTime") { t.FormatString = "dd-mm-yyyy" ;}
}
