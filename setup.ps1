$dotfiles = @{
    # dotfiles repo loc = loc relative to C:\Users\%USERNAME%
    ".gitconfig" = ".gitconfig"
    ".npmrc" = ".npmrc"
    ".prettierrc" = ".prettierrc"
    "windows\powershell\Microsoft.PowerShell_profile.ps1" = "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    "nvim\" = "AppData\Local\nvim\"
    "windows\winget\settings.json" = "AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
    "windows\terminal\settings.json" = "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}

foreach ($Key in $dotfiles.Keys) {
    
}