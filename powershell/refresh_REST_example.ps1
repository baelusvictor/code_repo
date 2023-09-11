#GET https://api.powerbi.com/v1.0/myorg/groups/f72f3129-587b-4536-872e-65398e15a28b/datasets/3058a228-9d2c-4ddc-9998-5c53aea14512/refreshes

#https://app.powerbi.com/groups/f72f3129-587b-4536-872e-65398e15a28b/datasets/3058a228-9d2c-4ddc-9998-5c53aea14512/details?experience=power-bi

Invoke-PowerBIRestMethod -Url "https://api.powerbi.com/v1.0/myorg/groups/f72f3129-587b-4536-872e-65398e15a28b/datasets/3058a228-9d2c-4ddc-9998-5c53aea14512/refreshes" -Method GET