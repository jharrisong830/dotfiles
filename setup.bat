@ECHO OFF

SETLOCAL EnableDelayedExpansion

:: arr[EVEN] -> location relative to this directory (dotfiles repo)
:: arr[ODD]  -> location relative to the user's home directory (C:\Users\%USERNAME%)

SET arr[0]=.gitconfig
SET arr[1]=.gitconfig

SET arr[2]=.npmrc
SET arr[3]=.npmrc

SET arr[4]=.prettierrc
SET arr[5]=.prettierrc

SET arr[6]=.prettierignore
SET arr[7]=.prettierignore

SET arr[8]=windows\powershell\Microsoft.PowerShell_profile.ps1
SET arr[9]=Documents\PowerShell\Microsoft.PowerShell_profile.ps1

SET arr[10]=nvim\
SET arr[11]=AppData\Local\nvim\

SET arr[12]=windows\winget\settings.json
SET arr[13]=AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json


@REM git -C "C:\Users\%USERNAME%\Developer\dotfiles" remote update > NUL

@REM SET gitRemoteStatus=git -C "C:\Users\%USERNAME%\Developer\dotfiles" status -uno

@REM IF ($gitRemoteStatus -match 'Your branch is behind') {
@REM     echo "New config changes detected, updating!"
@REM     git -C "C:\Users\%USERNAME%\Developer\dotfiles" pull > $null
@REM     echo "You might want to restart your session."
@REM }


:: symbolic links for user directory files

FOR /l %%i IN (0, 2, 12) DO (
    SET /A j=%%i+1
    FOR %%j IN (!j!) DO (
        FOR %%C IN (%~dp0!arr[%%i]!) DO (
            :: %%C = current dotfile full path (including file name) within the dotfiles repo
            IF "!arr[%%i]:~-1!" == "\" (
                :: directory symlink
                IF EXIST C:\Users\%USERNAME%\!arr[%%j]! (
                    :: delete file if it already exists (overwrite)
                    rmdir C:\Users\%USERNAME%\!arr[%%j]!
                )
                mklink /d C:\Users\%USERNAME%\!arr[%%j]! %%C
            ) ELSE (
                :: regular file
                IF EXIST C:\Users\%USERNAME%\!arr[%%j]! (
                    :: delete file if it already exists (overwrite)
                    del C:\Users\%USERNAME%\!arr[%%j]!
                )
                mklink C:\Users\%USERNAME%\!arr[%%j]! %%C
            )
        )
    )
)


ECHO "All symbolic links created. Done!"
