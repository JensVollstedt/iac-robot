Clear-Host
Write-Host "#####################################################"
Write-Host "## 'Robust Online Bicep Orcstration Tool' or ROBOT ##"
Write-Host "##  Version 1.0                                    ##"
Write-Host "##  Max Enroth maxenrothdk@gmail.com               ##"
Write-Host "#####################################################"
$input1 = Read-Host -Prompt "[Y/N] Are we using BICEP.MAIN?"
$input2 = Read-Host -Prompt "[Y/N] Are we using PARAMETERS.JSON?"
$input3 = Read-Host -Prompt "[R/S] What is your scope RESOURCEGROUP or SUBSCRIPTION"

# Y Y S (First)
# Y N S (Second)
# N N S (Third)
# N Y S (WIP)
# N N R
# 

# $bicep_file=$args[0] # Write the path to the bicep file

if ($input1 -eq "y" -and $input2 -eq  "y" -and $input3 -eq "s") {
az deployment sub create --location 'westeurope' --parameters parameters.JSON --template-file main.bicep > testfile.1 # Print output into a new file named testfile.1
Write-Host "sleeping" # Write to screen that we are sleeping
Start-Sleep 2 # Sleep for  2 sec
$result = Select-String testfile.1 -Pattern "Succeeded" # Search for the string pattern that has "succedded" in it

if ($result -like '*Succeeded*') {     # if $result has  Succedded 
Write-Host 'Provision worked'       # Success 
}else {                                # or
Write-Host 'Ups there were an error'# Failure
}
Remove-Item testfile.1                 # delete testfile.1 
}

if ($input1 -eq "y" -and $input2 -eq  "n" -and $input3 -eq "s") {
az deployment sub create --location 'westeurope' --template-file main.bicep > testfile.1 
Write-Host "sleeping" 
Start-Sleep 2 
$result = Select-String testfile.1 -Pattern "Succeeded"
if ($result -like '*Succeeded*') {    
Write-Host 'Provision worked' 
}else {                                
Write-Host 'Ups there were an error' 
}
Remove-Item testfile.1                  
}

if ($input1 -eq "n" -and $input2 -eq  "n" -and $input3 -eq "s") {
Write-Host "Write the full name of the Bicep file you with to deploy, remeber to include the .bicep"
$bicepfile = Read-Host
az deployment sub create --location 'westeurope' --template-file $bicepfile > testfile.1 
Write-Host "sleeping" 
Start-Sleep 2 
$result = Select-String testfile.1 -Pattern "Succeeded"
if ($result -like '*Succeeded*') {    
Write-Host 'Provision worked' 
}else {                                
Write-Host 'Ups there were an error' 
}
Remove-Item testfile.1                  
}
