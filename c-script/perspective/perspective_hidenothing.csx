foreach(var t in Model.Tables.ToList()){t.IsHidden = false;} ;

foreach(var m in Model.AllMeasures.ToList()){m.IsHidden = false;} ;

foreach(var c in Model.AllColumns.ToList()){c.IsHidden = false;} ;

foreach(var h in Model.AllHierarchies.ToList()){h.IsHidden = false;} ;
