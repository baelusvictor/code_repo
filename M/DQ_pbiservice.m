let
    Source = AnalysisServices.Database("powerbi://api.powerbi.com/v1.0/myorg/Finance", "source_finance"),
    Cubes = Table.Combine(Source[Data]),
    Cube = Cubes{[Id="Model", Kind="Cube"]}[Data]
in
    Cube