// Retrieves the maximum value of the column [LastUpdateDt]
let
    #"maxDateOfLastUpdate" =
        List.max(
            Orders[LastUpdateDt]
        ),

    accountForNu11 =
        if #"maxDateOfLastUpdate" = null
        then #datetime(1901, 01, 01, 00, 00, 00)
        else #"maxDateOfLastUpdate"
in
    accountForNu11
