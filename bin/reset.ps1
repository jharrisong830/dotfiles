function _unlink_target ([string]$target) {
    if (Test-Path -Path $target) {
        if (! (Test-Path -Type Container -Path $target)) {
            echo "Deleting $target"
            Remove-Item -Path $target
        } else {
            echo "Deleting directory $target"
            Remove-Item -Recurse -Force -Path $target
        }    
    }
}


foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\common\git") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "C:\Users\$env:USERNAME\$filename"

    _unlink_target $target
}

foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\common\js") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "C:\Users\$env:USERNAME\$filename"

    _unlink_target $target
}


foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\windows\powershell") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "C:\Users\$env:USERNAME\Documents\PowerShell\$filename"

    _unlink_target $target
}

foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\windows\winget") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\$filename"

    _unlink_target $target
}

foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\windows\terminal") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\$filename"

    _unlink_target $target
}


foreach ($original_file in Get-Item -Path "$(Get-Location)\common\nvim") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "$env:LOCALAPPDATA\$filename"

    _unlink_target $target
}

foreach ($original_file in Get-Item -Path "$(Get-Location)\common\alacritty") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "$env:LOCALAPPDATA\$filename"

    _unlink_target $target
}


echo "Done!"