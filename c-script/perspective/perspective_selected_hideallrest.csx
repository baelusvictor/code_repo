// TODO: Replace this with the name of your developer perspective
var persp = Selected.Perspective.Name; //"Private"; 

foreach(var t in Model.Tables.ToList()) 
    {
        if
        (t.InPerspective[persp]) 
        {t.IsHidden = false;} 
        else 
        {t.IsHidden = true;}
    };

foreach(var m in Model.AllMeasures.ToList())
    {
        if
        (m.InPerspective[persp]) 
        {m.IsHidden = false;} 
        else 
        {m.IsHidden = true;}
    };

foreach(var c in Model.AllColumns.ToList())
    {
        if
        (c.InPerspective[persp]) 
        {c.IsHidden = false;} 
        else 
        {c.IsHidden = true;}
    };

foreach(var h in Model.AllHierarchies.ToList())
    {
        if
        (h.InPerspective[persp]) 
        {h.IsHidden = false;} 
        else 
        {h.IsHidden = true;}
    };


