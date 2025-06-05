# Kullanıcıdan klasör yolu al
$folderPath = Read-Host "Enter PATH"

# Yolun varlığını kontrol et
if (!(Test-Path -Path $folderPath)) {
    Write-Host "ERROR: The specified path was not found." -ForegroundColor Red
    exit
}

# Oluşturma tarihi aralığı (2025-04-30 – 2025-05-15)
$creationStart = Get-Date "2025-04-30 00:00:00"
$creationEnd   = Get-Date "2025-05-15 23:59:59"

# Değiştirilme tarihi aralığı (2025-04-30 – 2025-05-28)
$modifiedStart = Get-Date "2025-04-30 00:00:00"
$modifiedEnd   = Get-Date "2025-05-28 23:59:59"

# Rastgele iş saati (09:00–17:59) içinde tarih üretme fonksiyonu
function Get-RandomBusinessDate {
    param(
        [DateTime]$Start,
        [DateTime]$End
    )
    $totalDays  = [int](($End.Date - $Start.Date).TotalDays)
    $randomDays = Get-Random -Minimum 0 -Maximum ($totalDays + 1)
    $baseDate   = $Start.Date.AddDays($randomDays)

    $hour   = Get-Random -Minimum 9 -Maximum 17
    $minute = Get-Random -Minimum 0 -Maximum 59
    $second = Get-Random -Minimum 0 -Maximum 59

    return $baseDate.AddHours($hour).AddMinutes($minute).AddSeconds($second)
}

# Kök klasör ve altındaki tüm öğeleri (klasörler + dosyalar)
$items = @( Get-Item -LiteralPath $folderPath ) `
       + @( Get-ChildItem -Path $folderPath -Recurse -Force )

# Her öğe için rastgele tarihler ata
foreach ($item in $items) {
    $creationTime = Get-RandomBusinessDate -Start $creationStart -End $creationEnd
    $writeTime    = Get-RandomBusinessDate -Start $modifiedStart -End $modifiedEnd

    if ($item.PSIsContainer) {
        [System.IO.Directory]::SetCreationTime($item.FullName, $creationTime)
        [System.IO.Directory]::SetLastWriteTime($item.FullName, $writeTime)
        [System.IO.Directory]::SetLastAccessTime($item.FullName, $writeTime)
    } else {
        [System.IO.File]::SetCreationTime($item.FullName, $creationTime)
        [System.IO.File]::SetLastWriteTime($item.FullName, $writeTime)
        [System.IO.File]::SetLastAccessTime($item.FullName, $writeTime)
    }
}

Write-Host "Tüm klasör ve dosyalar için rastgele tarih atamaları tamamlandı." -ForegroundColor Green
