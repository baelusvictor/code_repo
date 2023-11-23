# typ onderstaande commandos om een virtuele omgeving te creeeren on onderstaande folder
# je kan in deze virtuele folder dan testen of je extensies etc werken
# op zich is dit een best practice ondat je dan als je wil kan terugvallen

python -m venv C:\Virtual\test1p6\Scripts\Activate.ps1

pip install dbt-athena-community==1.6.4

C:\Virtual\test1p6\Scripts\Activate.ps1

#als je wil afzetten
deactivate

#gebruik cd.. om terug te gaan in je folderstructuur
cd..
