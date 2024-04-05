#in order to call scripts u need to give permission first
#open shell as admin an set policy
Set-ExecutionPolicy RemoteSigned

#check policy
Get-ExecutionPolicy

#go to the folder where the script is placed
cd C:\Users\victo\script

#start with . to indicate u want to use the current folder, type \ and get list of all the scripts there
.\hi.ps1

#this might still not work for a script that u just downloaded, in that case open it and toggle the popup off