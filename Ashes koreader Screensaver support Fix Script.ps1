[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
# Ash's KOReader Screen Saver Enabler :3 🎁🌸


function Show-FlowerAnimation($lines, $delay = 100) {
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor Green
        Start-Sleep -Milliseconds $delay
    }
}

function Show-DecayAnimation($lines, $delay = 100) {
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor DarkGray
        Start-Sleep -Milliseconds $delay
    }
}

function Show-Sparkles() {
    $sparkle = @(
        "       * ✧ ✦ ✧ *",
        " ✧･ﾟ: *✧･ﾟ:* ✨ *:･ﾟ✧*:･ﾟ✧",
        "       * ✧ ✦ ✧ *"
    )
    foreach ($line in $sparkle) {
        Write-Host $line -ForegroundColor Magenta
        Start-Sleep -Milliseconds 120
    }
}

function Show-EjectSparkle() {
    $sparkle = @(
        "✨ Please remember to ✨",
        "📤 Eject your Kindle and unplug it safely! 💛",
        "✨✨✨✨✨✨✨✨✨✨✨✨"
    )
    $colors = @("Yellow", "Magenta", "Yellow")
    for ($i = 0; $i -lt $sparkle.Count; $i++) {
        Write-Host $sparkle[$i] -ForegroundColor $colors[$i]
        Start-Sleep -Milliseconds 180
    }
}

function Show-ASH-Logo() {
    $ash = @(
        "                                                                                                                   ",
        "               AAA                 SSSSSSSSSSSSSSS HHHHHHHHH     HHHHHHHHHEEEEEEEEEEEEEEEEEEEEEE   SSSSSSSSSSSSSSS ",
        "              A:::A              SS:::::::::::::::SH:::::::H     H:::::::HE::::::::::::::::::::E SS:::::::::::::::S",
        "             A:::::A            S:::::SSSSSS::::::SH:::::::H     H:::::::HE::::::::::::::::::::ES:::::SSSSSS::::::S",
        "            A:::::::A           S:::::S     SSSSSSSHH::::::H     H::::::HHEE::::::EEEEEEEEE::::ES:::::S     SSSSSSS",
        "           A:::::::::A          S:::::S              H:::::H     H:::::H    E:::::E       EEEEEES:::::S            ",
        "          A:::::A:::::A         S:::::S              H:::::H     H:::::H    E:::::E             S:::::S            ",
        "         A:::::A A:::::A         S::::SSSS           H::::::HHHHH::::::H    E::::::EEEEEEEEEE    S::::SSSS         ",
        "        A:::::A   A:::::A         SS::::::SSSSS      H:::::::::::::::::H    E:::::::::::::::E     SS::::::SSSSS    ",
        "       A:::::A     A:::::A          SSS::::::::SS    H:::::::::::::::::H    E:::::::::::::::E       SSS::::::::SS  ",
        "      A:::::AAAAAAAAA:::::A            SSSSSS::::S   H::::::HHHHH::::::H    E::::::EEEEEEEEEE          SSSSSS::::S ",
        "     A:::::::::::::::::::::A                S:::::S  H:::::H     H:::::H    E:::::E                         S:::::S",
        "    A:::::AAAAAAAAAAAAA:::::A               S:::::S  H:::::H     H:::::H    E:::::E       EEEEEE            S:::::S",
        "   A:::::A             A:::::A  SSSSSSS     S:::::SHH::::::H     H::::::HHEE::::::EEEEEEEE:::::ESSSSSSS     S:::::S",
        "  A:::::A               A:::::A S::::::SSSSSS:::::SH:::::::H     H:::::::HE::::::::::::::::::::ES::::::SSSSSS:::::S",
        " A:::::A                 A:::::AS:::::::::::::::SS H:::::::H     H:::::::HE::::::::::::::::::::ES:::::::::::::::SS ",
        "AAAAAAA                   AAAAAAASSSSSSSSSSSSSSS   HHHHHHHHH     HHHHHHHHHEEEEEEEEEEEEEEEEEEEEEE SSSSSSSSSSSSSSS   "
    )
    $colors = @("Red", "Yellow", "Green", "Cyan", "Blue", "Magenta")
    $i = 0
    foreach ($line in $ash) {
        Write-Host $line -ForegroundColor $colors[$i % $colors.Count]
        $i++
        Start-Sleep -Milliseconds 60
    }
}

function Clear-And-Display($msg, $color = "Magenta") {
    Start-Sleep -Milliseconds 500
    Write-Host "`n(｡◕‿◕)｡*:.☆" -ForegroundColor $color
    Start-Sleep -Milliseconds 300
    Show-Sparkles
    Start-Sleep -Milliseconds 600
    Clear-Host
    Write-Host "`n$msg`n" -ForegroundColor $color
    Write-Host ""
    Show-EjectSparkle
    Write-Host "`nPress any key to exit..." -ForegroundColor DarkCyan
    [void][System.Console]::ReadKey($true)
    Write-Host "`nsee ya later !!! >w< <3" -ForegroundColor Magenta
    Show-ASH-Logo
}

# 🎀 Intro
Clear-Host
Write-Host "============================================="
Write-Host "    Ashes KOReader Screen Saver Enabler :3"
Write-Host "============================================="
Write-Host " original method by: u/mc711 on reddit (thank you!!)"
Write-Host " wrapped automation script Ash 🎁✨"
Write-Host "---------------------------------------------`n"
Write-Host " KOReader usually disables screensavers on SO (Special Offer) Kindles."
Write-Host " When KOReader updates, it overwrites the 'device.lua' file"
Write-Host " — which resets screensaver support back to OFF :("
Write-Host " That's why this script exists; to help you fix it instantly! ^_^"
Write-Host "`nPress any key to continue..."
[void][System.Console]::ReadKey($true)

# 🔍 Locate Kindle
Write-Host "`n[*] Scanning for Kindle..."

# Try common macOS mount first
$candidates = @(
    "/Volumes/Kindle/koreader/frontend/device/kindle/device.lua"
)

# Also scan all mounted filesystem roots PowerShell sees
$candidates += (Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    Join-Path $_.Root "koreader/frontend/device/kindle/device.lua"
})

$deviceLua = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $deviceLua) {
    $mountPath = Read-Host "Couldn't auto-detect your Kindle 😢`nPlease enter the mount path (e.g., /Volumes/Kindle)"
    $deviceLua = Join-Path $mountPath "koreader/frontend/device/kindle/device.lua"
    if (-not (Test-Path $deviceLua)) {
        Write-Error "Still can't find KOReader at that location. Aborting!"
        exit 1
    }
} else {
    Write-Host "[OK] Found your Kindle at $deviceLua :3"
}

# 🌼 Animation text
$flowerBloom = @'
         .-""--.,
       /` \.-.{/ \
      /  .' ; '.  \
      | /       \ |
      |/         \|
      T      :    Y
      |      :    ;
      |      :    |
|\.   \     :     /
| \'.  '.  .    .'
| |  \   `"T=T"`
| /   \    | |
|` :   |   | |
\   :  |   | |    _ 
 |   .  \  | |  /` `-._
 |   :   | | | |   .'  /'.
 \   .   | | | |  .   |   `\
 |       | | | |      /     |
 |   '    \| | | :   /'-.   |
  \   '   || |/  ;   |   \  /
  |   :   ;| ||  .   |   '-'
  \   :   || |/ ;    /
   |   '  ;| |  '   |
    \  :  || | '   /
     `\ ' \| ;'   /
   jgs `\' | |  /`
         `\| |/`
           | |
           | |
           | |
           |/
'@ -split "`n"

# 🔁 Check and patch
$code = Get-Content -Raw $deviceLua
$enabledPattern = '(?s)function Kindle:supportsScreensaver\(\)\s*.*?if\s+self\.isSpecialOffers\s+then\s+return\s+true'
$disabledPattern = '(?s)function Kindle:supportsScreensaver\(\)\s*.*?if\s+self\.isSpecialOffers\s+then\s+return\s+false'

if ($code -match $enabledPattern) {
    $resp = Read-Host "KOReader screen saver is already enabled 🌸 `nDo you want to disable it? (y/n)"
    if ($resp -match '^(y|yes)$') {
        Clear-Host
        Show-DecayAnimation -lines $flowerBloom -delay 80
        $patched = [regex]::Replace($code, $enabledPattern, { param($m) $m.Value -replace 'return\s+true', 'return false' })
        Set-Content $deviceLua $patched
        $msg = "🥀 KOReader screen saver has been DISABLED (set to false) 💤"
        Clear-And-Display $msg "DarkRed"
    } else {
        Write-Host "No changes made! KOReader screen saver is still ENABLED"
    }
}
elseif ($code -match $disabledPattern) {
    Clear-Host
    Show-FlowerAnimation -lines $flowerBloom -delay 80
    $patched = [regex]::Replace($code, $disabledPattern, { param($m) $m.Value -replace 'return\s+false', 'return true' })
    Set-Content $deviceLua $patched
    $msg = "🌸 KOReader screen saver is now ENABLED :3"
    Clear-And-Display $msg "Green"
}
else {
    Write-Warning "Couldn’t find the expected line to patch.`nMaybe this version of KOReader is different?"
}

