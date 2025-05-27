# Check if script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as administrator!"
    Start-Sleep -Seconds 3
    exit
}

# Generate timestamp for filename
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Define paths
$samplePath = "C:\MalwareLab\PE_FILE.exe"
$winpmemPath = "C:\Tools\winpmem_mini_x64_rc2.exe"
$outputPath = "C:\Tools\memdump_$timestamp.elf"
$sharedFolder = "X:\"

# Launch the PE file
Start-Process -FilePath $samplePath
Start-Sleep -Milliseconds 70

# Run WinPmem synchronously
& $winpmemPath "$outputPath"

# Wait until the .elf file is created (timeout 60 sec)
$timeout = 60
$waited = 0
while (-not (Test-Path $outputPath) -and $waited -lt $timeout) {
    Start-Sleep -Seconds 1
    $waited++
}

if (-not (Test-Path $outputPath)) {
    Write-Error "Memory dump not found – something went wrong."
    exit 1
}

# Copy dump file to shared folder
Copy-Item -Path $outputPath -Destination $sharedFolder

# Notify user and open the shared folder
Write-Host "`nMemory dump completed and copied to shared folder!"
Start-Process explorer.exe $sharedFolder
