// Instructions
  // ------------
  // 1. Save this script as a macro with a context of 'Column' and 'Measure'
  // 2. Configure a keyboard shortcut for the macro (i.e. ALT + C) if using Tabular Editor 3
  // 3. Select any combination of columns & measures related in the model & run the script
  // 4. The output will return the evaluation result of all selected objects, assuming it is valid  
  
  
  // Get column names
  var _ColumnsList = new List<string>();
  foreach ( var _SelectedColumn in Selected.Columns )
  {
      _ColumnsList.Add(_SelectedColumn.DaxObjectFullName);
  }
  string _Columns = String.Join(",", _ColumnsList );
  
  
  // Get measure names
  var _MeasuresList = new List<string>();
  var _MeasuresOnlyList = new List<string>();
  foreach ( var _SelectedMeasure in Selected.Measures )
  {
      // Create a syntax for evaluating objects when measures + columns are selected     
      _MeasuresList.Add( @"""@" + _SelectedMeasure.Name + @"""" );
      _MeasuresList.Add(_SelectedMeasure.DaxObjectFullName);
  
      // Create a syntax for evaluating objects when only measures are selected
      _MeasuresOnlyList.Add( 
          "\nADDCOLUMNS (\n{" + 
          @"""" + _SelectedMeasure.Name + @"""" + 
          "},\n" + 
          @"""" + "Result" + @"""" + 
          ",\n" + 
          _SelectedMeasure.DaxObjectFullName + ")");
  }
  string _Measures = String.Join(",", _MeasuresList );
  
  
  // Results differ depending on how many columns, measures are selected
  int _NrMeasures = Selected.Measures.Count();
  int _NrColumns = Selected.Columns.Count();
  
  
  // ----------------------------------------------------------------------------------------//
  // Result if a combination of measures & columns are selected
  if ( _NrMeasures > 0 && _NrColumns > 0 )
  {
      // Summarize selected columns + measures with DAX
      string _dax = 
          "SUMMARIZECOLUMNS ( " + _Columns + ", " + _Measures + ")";
  
      // Return output in pop-up
      EvaluateDax(_dax).Output();
  }
  
  
  // ----------------------------------------------------------------------------------------//
  // Result if no columns and more than 1 measure are selected
  else if ( _NrColumns == 0 && _NrMeasures > 1 )
  {
      // Evaluate each measure as a separate row
      string _dax = 
          "SELECTCOLUMNS( UNION ( " +                    // SELECTCOLUMNS to re-name cols, UNION to combine rows
          String.Join(",", _MeasuresOnlyList ) + ")," +  // Concatenate list of measure evaluations
          @"""" + "Measure Name" + @"""" +               // Rename 1st col "Measure Name"
          ", [Value]," +                                 // 
          @"""" + "Measure Result" + @"""" +             // Rename 2nd col "Measure Result"
          ", [Result])" ;                                // 
  
      // Return output in pop-up
      EvaluateDax(_dax).Output();
  }
  
  
  // ----------------------------------------------------------------------------------------//
  // Result if no columns and exactly one measure are selected
  else if ( _NrColumns == 0 && _NrMeasures == 1 )
  {
      // Evaluate each measure as a separate row
      string _dax =                                      
          "SELECTCOLUMNS( " +                           // SELECTCOLUMNS to re-name cols
          String.Join(",", _MeasuresOnlyList ) + "," +  // Concatenate list of measure evaluations 
          @"""" + "Measure Name" + @"""" +              // Rename 1st col "Measure Name" 
          ", [Value]," +                                //  
          @"""" + "Measure Result" + @"""" +            // Rename 2nd col "Measure Result"
          ", [Result])" ;                               // 
  
      // Return output in pop-up
      EvaluateDax(_dax).Output();
  }
  
  
  // ----------------------------------------------------------------------------------------//
  // Result if only columns and no measures are selected
  else
  {
      // Summarize selected columns with DAX
      string _dax = 
          "SUMMARIZECOLUMNS ( " + _Columns + ")";
  
      // Return output in pop-up
      EvaluateDax(_dax).Output();
  }
  