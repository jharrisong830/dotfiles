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

function _link_dotfiles ([string]$filename, [string]$original_file, [string]$target) {
    echo "[ $filename ]"

    _unlink_target -target $target

    echo "Linking $original_file to $target"
    
    # backwards naming from zsh setup, $target is the -Path where the link will be, $original_file is the -Target file to be linked to
    New-Item -ItemType SymbolicLink -Path $target -Target $original_file 
    echo ""
}


foreach ($original_file in Get-ChildItem -Path "$(Get-Location)\common\git") {
    $filename = Split-Path -Path $original_file -Leaf
    $target = "C:\Users\$env:USERNAME\$filename"

    _link_dotfiles -filename $filename -original_file $original_file -target $target
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
