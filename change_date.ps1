# Prompt user for folder path
$folderPath = Read-Host "Enter PATH"

# Check if folder exists
if (!(Test-Path -Path $folderPath)) {
    Write-Host "ERROR: The specified folder was not found." -ForegroundColor Red
    exit
}

# Prompt user for date input
$dateInput = Read-Host "Enter the new date (example: 01.01.2024 10:00:00)"

# Validate date format
try {
    $newDate = Get-Date $dateInput
} catch {
    Write-Host "ERROR: Invalid date format. Please use this format: 01.01.2024 10:00:00" -ForegroundColor Red
    exit
}

# Load required .NET type
Add-Type -AssemblyName mscorlib

# Change folder timestamps
[System.IO.Directory]::SetCreationTime($folderPath, $newDate)
[System.IO.Directory]::SetLastWriteTime($folderPath, $newDate)
[System.IO.Directory]::SetLastAccessTime($folderPath, $newDate)

# Change timestamps for all files inside the folder
Get-ChildItem -Path $folderPath -File | ForEach-Object {
    [System.IO.File]::SetCreationTime($_.FullName, $newDate)
    [System.IO.File]::SetLastWriteTime($_.FullName, $newDate)
    [System.IO.File]::SetLastAccessTime($_.FullName, $newDate)
}

Write-Host "The folder and all contained files have been successfully updated." -ForegroundColor Green
