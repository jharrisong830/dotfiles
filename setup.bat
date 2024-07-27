@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET arr[0]=.gitconfig
SET arr[1]=.npmrc
SET arr[2]=.prettierrc
SET arr[3]=.prettierignore
SET arr[4]=Documents\PowerShell\Microsoft.PowerShell_profile.ps1
SET arr[5]=AppData\Local\nvim\
SET arr[6]=AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json


@REM git -C "C:\Users\%USERNAME%\Developer\dotfiles" remote update > NUL

@REM SET gitRemoteStatus=git -C "C:\Users\%USERNAME%\Developer\dotfiles" status -uno

@REM IF ($gitRemoteStatus -match 'Your branch is behind') {
@REM     echo "New config changes detected, updating!"
@REM     git -C "C:\Users\%USERNAME%\Developer\dotfiles" pull > $null
@REM     echo "You might want to restart your session."
@REM }


:: symbolic links for user directory files

FOR /l %%i IN (0, 1, 6) DO (
    :: !arr[%%i]! = current dotfile relative path from user directory (C:\Users\%USERNAME%)
    FOR %%C IN (%~dp0!arr[%%i]!) DO (
        :: %%C = current dotfile full path (including file name)
        ECHO %%C

        IF !arr[%%i]:~-1! == "\" (
            :: directory symlink
            FOR %%B IN (%%~nC) DO (
                :: %%B = current directory basename
                IF EXIST C:\Users\%USERNAME%\!arr[%%i]! (
                    :: delete file if it already exists (overwrite)
                    del C:\Users\%USERNAME%\!arr[%%i]!
                )
                mklink /d C:\Users\%USERNAME%\!arr[%%i]! %~dp0%%B
            )
        ) ELSE (
            :: regular file
            FOR %%B IN (%%~nxC) DO (
                :: %%B = current dotfile basename
                IF EXIST C:\Users\%USERNAME%\!arr[%%i]! (
                    :: delete file if it already exists (overwrite)
                    del C:\Users\%USERNAME%\!arr[%%i]!
                )
                mklink C:\Users\%USERNAME%\!arr[%%i]! %~dp0%%B
            )
        )
    )
)


ECHO done!
