Function Install-Crome{
param(
[string]$ChromeLink = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B08E9D9DD-49B9-0C89-E561-438EB1C2ACAC%7D%26lang%3Den%26browser%3D5%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe',
[string]$FilePath = 'c:\temp\ChromeStandaloneSetup64.exe'
)

$Chrome = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe' -ErrorAction SilentlyContinue).'(Default)' -ErrorAction SilentlyContinue).VersionInfo
if ($Chrome)
    {
        Write-Host "Chrome Exist, Version : $($Chrome.ProductVersion)"
    }else{ 

function temp-folder(){
    if (Test-Path -Path C:\temp -ErrorAction SilentlyContinue)
        {
            Write-Host "Temp folder exist"
        }
    else
        {
            Write-Host "No folder"
            New-Item -Path c:\ -Name temp -ItemType directory -Force
        }
}

if (Get-ChildItem -Path $FilePath -ErrorAction SilentlyContinue)
    {
        Write-Host "File In local Path"        
    }
else
    {
        temp-folder
        Write-Host "Downloading Chrome, This might take a while";
        try{
            Invoke-WebRequest -Uri $ChromeLink -Method Get -OutFile $FilePath -ErrorAction Stop
           }
        catch{
            $_.Exception; break
             }
        Write-Host "Download Completed" -ForegroundColor Green
        & $FilePath /silent /install
    }
    & $FilePath /silent /install
    }
}
Install-Crome
