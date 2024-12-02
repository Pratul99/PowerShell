# To check Powershell version

$Host 
or
$PSVersionTable

# ------------------------------------------------------------- x ----------------------------------------------------------


# In PS if you want to use Boolean, have to use it with "$".
($true).GetType()

# In PS if you want to make user defined variable use "$"
$name = "Pratul"
$name
    
# Variables are not case sensitive.

# ------------------------------------------------------------- x ----------------------------------------------------------

# 04-09-2024
# ---------

# Get-Service | Select-Object -Last 10 | Select-Object Status, Name
$a = Get-Service

$a | Select-Object -Last 20 | Select-Object Status, Name | Export-Csv .\test.csv -NoTypeInformation

# $_ = $PSItem (Pipeline variable)
# Tee-Object, Format-List,Table has to be used at the end because after it other cmds can't be used.

$a | Where-Object{$_.Status -eq "Running"} | Select-Object -Last 10 | Format-List

# To load content in PowerShell Memory.
$b = Get-Content .\ps\1.txt
$c = Get-Content .\ps\2.txt

Compare-Object -ReferenceObject $b -DifferenceObject $c -IncludeEqualS

$d = Import-Csv .\ps\3.csv
$d | Select-Object -Last 1 | Format-Table -AutoSize

$d | Select-Object -Last 2 | Select-Object Name, Location

#expression
$d | Select-Object -Last 2 | Select-Object Name, @{l="Location";e={$_.Place}}

# ------------------------------------------------------------- x ----------------------------------------------------------

# Scripts block
# -------------

$sb = {
    Write-Host "This is a script block" -ForegroundColor Green
    Get-Service -Name WinRM
}

Invoke-Command -ScriptBlock {
    Write-Host "This is a script block" -ForegroundColor Green
    Get-Service -Name WinRM                                             
}

$sb.Invoke()

$a | Where-Object {$_.Status -eq "Running"} 

# ------------------------------------------------------------- x ----------------------------------------------------------

# Function
# --------

#1
function Show-Text {
    Write-Host "This is a simple Function" -ForegroundColor Blue
    Get-Service -Name WinRM
}

Show-Text

#2
function Show-Text1($message, $serviceName) {
    Write-Host "$message" -ForegroundColor Red
    Get-Service -Name $serviceName
}

Show-Text1 -message "From param 1" -serviceName "BITS"

#3
function Show-Text2 {
    param (
        [Parameter(Mandatory)]
        $Message,
        $ServiceName
    )
    Write-Host "$Message" -ForegroundColor Yellow
    Get-Service -Name "$ServiceName"

} 


Show-Text2 -Message "From param 1" -ServiceName "BITS"

# ------------------------------------------------------------- x ----------------------------------------------------------

# SCOPES
# ------

$a = 123                             # Global Scope

function test {
    param (
        $a = 456                     # Child Scope
    )
    Write-Host $a  
}

$a
test

# ------------------------------------------------------------- x ----------------------------------------------------------

<# 05-09-2024

Array
----

Array starting index is = 0     &     Last Index = Length - 1 or -1
Last index of Array is always 1 less then it's lenght.
Dynamic Array = Array list
Method will have (), properties does not have.
#>

# Arrey Sub-Expression operator.
$arr = @()    # empty array

$arr += "A"   # Add somwthing is array, it just create new array doesn't add to existing array.
$arr += "B"
$arr[0] = "U"

# First element in Array
$arr[0]

# Last element in Array
$arr[-1]
# $arr[length -1]

$arr.Length
$arr.Contains("Z")


# Set value method  
$a.setvalue(250,1) # This set the valueof index 1 to 250

Get-Member -InputObject $arr

# Array List
# ----------

$arrlist = New-Object -TypeName System.Collections.ArrayList

Get-Member -InputObject $arrlist

$arrlist.Add(1)
$arrlist.Add("A") | Out-Null

# Remove all elements from an array list object.
$arrlist.Clear()

# Remove a specific element from an array list object.
$arrlist.Remove()

$arrlist

# ------------------------------------------------------------- x ----------------------------------------------------------

# Hashtable
# ---------

# Elements stored in it is stored as key value pair.
# Key cannot be duplicate.

$p = @{
    Name = "Pratul"
    Age = 25
    Location = "Delhi"
}

# Type check
$p.GetType()

# Member retrival
$p["Name"]

# New value
$p.Name = "Bhatt Ji"

$p.Add("Height", 5.10)
$p.Remove("Name")
$p.GetEnumerator()

$p

# Ordered distionary

$p = [ordered] @{ Name = "Pratul"; Age = 25; Location = "Delhi"}

# ------------------------------------------------------------- x ----------------------------------------------------------

<#
Comment block
#>
# ------------------------------------------------------------- x ----------------------------------------------------------

<#
06-09-2024
----------

Loops
----- 
#>

<#
For loop
--------

Has 1. Counter variable 2. range/condition 3. increment or decrement
#>

for($i=0; $i -lt 10; $i++)
{
    Write-Host "Current i = $i"
    Write-Host "Testing for loop" -ForegroundColor Magenta
}

# Table of 2

for($i=1; $i -le 10; $i++)
{
    Write-Host "2 x $i = $(2*$i)" or (2*$i)
}



<#
While loop   
----------

In while loop condition is checked first if it is true then only it will execute.
#>

$a = 1; 
while($a -le 10) 
{
    Write-Host "3 x $a = $(3*$a)"
    $a++
}



<#
Do While loop
-------------

In do-while loop condition is checked after body is executed, when we need to run loop atleast once we use do while loop.
#>

$b = 1;
do {
    Write-Host "4 x $b = $(4*$b)"
    $b++
}
while($b -le 10)


$i =6
do {
    Write-Output "$i / 2 = $($i/2)"
    $i++
}
while($i -le 5)


<#
do-until
-----------

Till the condition is false loop will run.
#>

$c = 20;
do {
    Write-Host "5 x $c = $(5*$c)"
    $c--
}
until($c -lt 10)


<#
for each loop
-------------

 #>

$z = @("Pratul", "pb", "Lalit", "Mohan")

foreach($item in $z)
{
    Write-Host "Name is $item"
}


for($i=0; $i -lt $z.Length; $i++)
{
    Write-Host "Name is $($z[$i])"
}


# To get out of loop use key word break.

$v = @("Mahadev", "Rama", "Ganesha", "hero")

for($i=0; $i -lt $v.Length; $i++)
{
    # break keyword
    if($i -gt 2) {
        break;
    }
    
    Write-Host "Name is $($v[$i])"
}


for($i=0; $i -lt $v.Length; $i++)
{
    # Continue keyword
    if($i -eq 1) {
        continue;
    }
    Write-Host "Name is $($v[$i])"
}


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
07-09-2024
----------

Where-object
------------
#>


$a | Where-Object {$_.Status -eq "Running"} 

Get-Service | Where-Object {$_.Status -eq "Running" -and $_.Name -Like "*Win*"}


<#
Select-Object
-------------
#>

Get-Service | Select-Object Name, Status -First 10


<#
ForEach-Object
--------------
#>

Get-Service | ForEach-Object {Write-Host "The service is $($_.Name)"}




<#
Custom function
---------------
#>

function custom-func {
    param (
        # Param
        [Parameter(ValueFromPipeline)]
        [string[]]
        $computerName=$env:COMPUTERNAME
    )
    foreach($z in $computerName)
    {
        Write-Host "The Computer name is $z" -ForegroundColor DarkCyan
    }
    
}

custom-func


function custom-func {
    param (
        # Param
        [Parameter(ValueFromPipeline)]
        [string[]]                         #string array
        $computerName=$env:COMPUTERNAME
    )
    begin{
        Write-Host "Begin block called" -ForegroundColor Green
    }
    process{
            Write-Host "The computer name is $computerName" -ForegroundColor Red
    }
    end{
        Write-Host "End block called" -ForegroundColor Yellow
    }
}

@("MahaDev", "SitaRam") | custom-func


# ------------------------------------------------------------- x ----------------------------------------------------------


<#
08-09-2024
----------
#>

Get-Process notepad | Stop-Process 

# ` is used to comtinue code in next line. For readibility purpose.
ex. Get-WmiObject -class win32_computersystem `
-computerName $computerName


 #string array as Param

param (
        # Param
        [Parameter(ValueFromPipeline)]
        [string[]]                         #string array
        $computerName=$env:COMPUTERNAME
    )

     #string as Param
     param (
        # Param
        [Parameter(ValueFromPipeline)]
        [string]                         #string
        $computerName=$env:COMPUTERNAME
    )



#Region Custom variable

Get-Content -Path r:\doesnotexist.txt -ErrorVariable BadThings   # If did +BadThings would add content to existing 
$BadThings


if ($BadThings) {
    Write-Host -ForegroundColor Blue "Had an issue, $($BadThings.Exception.Message)"
}

#Endregion


#Region Custom variable

try {
    Get-Content -Path r:\doesnotexist.txt -ErrorAction Stop
}
catch {
    Write-Output "Something went wrong, don't know what it was?"
}

#Endregion


#Region Custom variable
try {
    Get-Content -Path r:\notexist.txt -ErrorAction Stop
}
catch {
    $errorMessage = $_.Exception.Message
    Write-Output "Something went wrong - $errorMessage"
}

#Endregion


<#
02-12-2024
----------
#>

# A try block can have multiple catch block for different type of errors.

# The finally block in PowerShell is a reliable way to execute cleanup or finalization code regardless of success or failure in the preceding try or catch blocks.
try {
    # Code that might throw an exception
}
catch {
    # Code to handle exceptions
}
finally {
    # Code that always runs, whether or not an exception occurred
}


# ------------------------------------------------------------- x ----------------------------------------------------------


<#
09-09-2024
----------
#>


New-Item -Name test1 -ItemType Directory
Remove-Item .\test1 

New-Item -Name file1.txt -ItemType File -Value "Har Har MahaDev" -Path .\test1\
Get-Content .\test1/file1.txt


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
10-09-2024
----------
#>


# String Creation

$FirstName = "Pratul"
$Surname = "Bhatt"

# String Concatenation

"Hi, My Name is " + $FirstName.ToUpper() + " and my surname is " + $Surname.ToUpper() + ", nice to meet you."

# String Interpolation

"Hi, My Name is $FirstName and my surname is $($Surname.ToUpper()), nice to meet you."

# -f

"Hi, My Name is {0} and my surname is {1}, nice to meet you" -f $FirstName, $Surname.ToUpper()


Update-Help
Get-Help bitlocker


# Joining Strings

$FullName = "$FirstName $Surname"
$FullName

# String method

$FullName
$FullName.IndexOf(' ')
$index = $FullName.IndexOf(' ')

$FullName.Substring($index + 1)


# Creating a username with three first letter of firstname, followed by underscore, followed by surname  from fullname.

$FullName
$FullName.IndexOf(' ')
$index = $FullName.IndexOf(' ')

$Fir = $FullName.Substring(0, 3)
$Sur = $FullName.Substring($index + 1)

$UserName = "{0}_{1}" -f $Fir, $Sur
$UserName 

# PowerShell equavalent of grep

vssadmin list shadows | Select-String "creation time:" -Context 1,4
Get-Content C:\windows10upgrade.log | Select-String "Error"


# Regex - Regular Expression https://regexr.com/

$time | Select-String -Pattern '(\d+\.\d+s)$'

<#
02-12-2024
----------
#>

# Character groups in Regex
'big' -match 'b[oiu]g'

# Character ranges
99 -match '[0-9][0-9]'

# Word character  '\w' mean all from a-z & A-Z & 0-9
'Book' -match '\w'

# \d sub expression
'123-456-7891' -match '\d{3}-\d{3}-\d{4}'

# Anchor in regex
'boating' -match '^boat$'

# ------------------------------------------------------------- x ----------------------------------------------------------


<#
17-09-2024
----------
#>

# The shorthand for Where-Object in PowerShell is ?.

Example:

Get-Process | ? { $_.Name -like "chrome*" } 

# This command is equivalent to:

Get-Process | Where-Object { $_.Name -like "chrome*" } 


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
19-11-2024
----------
#>

`n is used for new line.

# ex. 

"Cat `nDog `nCamel"

# We can declar objects like ex. $a = 1,2,4    or  1...20

# user "Recurse" to get the list of item inside child item
ex. Get-ChildItem -Path "///" -Recurse -Force

# Join & split statments

ex. $a = "A", "B", "C"

$a -split ","


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
20-11-2024
----------
#>

# If else statement

$a = 17
$c = $a%2

if ($c -eq 0) {
    Write-Output "The Number is even"
}
else {
        Write-Output "The Number is not even"
    }




# else if statement

$a = 0
if ($a -gt 0) {
    Write-oitput "The Number greater then Zero"
}
elseif ($a -lt 0) {
    Write-Output "The Number is less then Zero"
}
else {
    Write-Output "The Number is Zero"
}


$time = Get-Date -Format HH

if ($time -le 10) {
    Write-Output "Good Morning !!"
}
elseif ($time -le 20) {
    Write-Output "Good Day"
}
else {
    Write-Output "Good Evening"
}



# Switch statement

$a = Read-Host -Prompt "Write enter between 1 & 3"

$a

switch ($a) {
    1 {$r = "One"}
    2 {$r = "Two"; break }
    3 {$r = "Three"}
    2 {$r = "Four"}
    Default {$r = "One"}
}
$r

or you can write above as below as well.

$a = Read-Host -Prompt "Enter your Fav num of the week:"

$r = switch ($a) {
    0 {"Sunday"}
    1 {"Monday"}
    2 {"Tuesday"}
    3 {"Wednesday"}
    4 {"Thursday"; break}
    5 {"Friday"}
    6 {"Saturday"}
    4 {"yoyo"}
    Default {"Friday"}
}

$r


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
02-12-2024
----------
#>


# Alias

New-Alias -Name svc -Value Get-Service
svc

# Get Alias

Get-Alias
Get-Alias -Name svc

# Export Alias
Export-Alias -Path E:\Downloads\export.txt -Name svc 

# To prevent overwrite use NoClobber
Export-Alias -Path E:\Downloads\export.txt -Name svc -NoClobber

# --------------------------------- x ----------------------------------

# To open all file in a dir
Invoke-Item -Path "E:\Downloads\*.txt"

# Set service
# Example to change display name of any service.  Set-Service -Name notepad -DisplayName NN or  Set-Service -Name PhoneSvc -StartupType Automatic


# ------------------------------------------------------------- x ----------------------------------------------------------

<#
02-12-2024
----------
#>