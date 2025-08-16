$dotfiles = @{
    # dotfiles repo loc = loc relative to C:\Users\%USERNAME%
    ".gitconfig" = ".gitconfig"
    ".npmrc" = ".npmrc"
    ".prettierrc" = ".prettierrc"
    "windows\powershell\Microsoft.PowerShell_profile.ps1" = "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    "nvim\" = "AppData\Local\nvim\"
    "windows\winget\settings.json" = "AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
    "windows\terminal\settings.json" = "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    ".bunfig.toml" = ".bunfig.toml"
}

echo "~~~ LINKING FILES... ~~~"
foreach ($Key in $dotfiles.Keys) {
    $DotfileRealPath = Resolve-Path $Key
    $DotfileLinkPath = "C:\Users\$env:USERNAME\$($dotfiles[$Key])"
    
    if (Test-Path -Path $DotfileLinkPath) {
        echo "Unlinking/removing $DotfileLinkPath"
        Remove-Item -Path $DotfileLinkPath -Force
    }

    echo "Adding $DotfileLinkPath, linked to $DotfileRealPath"
    New-Item -ItemType SymbolicLink -Path $DotfileLinkPath -Target $DotfileRealPath | Out-Null
}
