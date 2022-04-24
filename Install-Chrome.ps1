Function Install-Chrome{
[CmdletBinding()]
param(
[string]$ChromeLink = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B08E9D9DD-49B9-0C89-E561-438EB1C2ACAC%7D%26lang%3Den%26browser%3D5%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe'
)
$TempFolder = "ChromeStandaloneSetup64"
$OutFile = "c:\ChromeStandaloneSetup64\ChromeStandaloneSetup64.exe"
$Chrome = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe' -ErrorAction SilentlyContinue).'(Default)' -ErrorAction SilentlyContinue).VersionInfo
function Temp-Folder($Code){
if ($Code -eq 0){
    if (Test-Path -Path C:\$TempFolder -ErrorAction SilentlyContinue)
        {
            Write-Verbose "Temp folder exist"
        }
    else
        {
            Write-Verbose "Temp folder will be created"
            New-Item -Path c:\ -Name $TempFolder -ItemType directory -Force
        }
}
if ($Code -eq 1){
    Write-Verbose "Clean file and folder"
    Remove-Item -Path c:\$TempFolder -Recurse -Force
}
}
Function Install-GoogleChrome{
try{
            Write-Verbose "Downloading Chrome, This might take a while";
            Invoke-WebRequest -Uri $ChromeLink -Method Get -OutFile $OutFile -ErrorAction Stop
           }
        catch{
            $_.Exception; break
             }
        Write-Verbose "Download Completed" 
        Start-Process -FilePath $OutFile -ArgumentList "/silent", "/install" -Wait
        #& $OutFile /silent /install
}

if ($Chrome)
    {
        Write-Verbose "Chrome Exist, Version : $($Chrome.ProductVersion)"
    }
else
    { 
        temp-folder -Code 0
        Install-GoogleChrome
        temp-folder -Code 1
    }
}
Install-Chrome 


