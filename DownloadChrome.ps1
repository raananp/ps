Function Download-Crome{
$ChromeLink = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B08E9D9DD-49B9-0C89-E561-438EB1C2ACAC%7D%26lang%3Den%26browser%3D5%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/chrome/install/ChromeStandaloneSetup64.exe'
$FilePath = 'c:\temp\ChromeStandaloneSetup64.exe'
if (Get-ChildItem -Path $FilePath)
    {
        Write-Host "File In local Path"
        (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
    }
else
    {
        Write-Host "Downloading Chrome, This might take a while";
        try{Invoke-WebRequest -Uri $ChromeLink -Method Get -OutFile $FilePath}catch{$error}
        Write-Host "Download Completed" -ForegroundColor Green
        & $FilePath /silent /install
    }
}

