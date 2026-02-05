Set-PSReadLineOption -PredictionSource None # disable suggestions
Clear-Host # get rid of the version message

$ESC = [char]27 # usage for color: $ESC[<colorcode>m

function getGitBranchString {
    if (Get-Command "git" -ErrorAction Ignore) {
        $currBranch = git branch --show-current
        if (! $currBranch) { return "" }
        else {
            return "$ESC[35m$([char]0xf418) $currBranch$ESC[0m "
        }
    } else { return "" }
}

function prompt {
    return "$ESC[31m$env:USERNAME$ESC[0m @ $ESC[32m$env:COMPUTERNAME$ESC[0m: $ESC[34m$(Split-Path -Path $pwd -Leaf)$ESC[0m $(getGitBranchString)> "
}

if (Test-Path -Path "C:\Users\$env:USERNAME\Apps\Notepad++") { # add notepad++ to path
    $env:PATH += ";C:\Users\$env:USERNAME\Apps\Notepad++"
}

if (Test-Path -Path "C:\Users\$env:USERNAME\scoop\apps\openjdk\current\bin") { # add openjdk to front of path (incase java8 occurs first)
    $env:PATH = "C:\Users\$env:USERNAME\scoop\apps\openjdk\current\bin;" + $env:PATH
}

function _rm-rf { Remove-Item -Recurse -Force -Path @args }
Set-Alias -Name rm-rf -Value _rm-rf

if (Get-Command "git" -ErrorAction Ignore) {
    function _gs { git status @args } 
    Set-Alias -Force -Name gs -Value _gs

    function _gl { git log @args } 
    Set-Alias -Force -Name gl -Value _gl

    function _gln { git log -n @args }
    Set-Alias -Force -Name gln -Value _gln

    function _gd { git diff @args }
    Set-Alias -Force -Name gd -Value _gd

    function _gc { git commit @args } 
    Set-Alias -Force -Name gc -Value _gc

    function _gcm { git commit -m @args } 
    Set-Alias -Force -Name gcm -Value _gcm

    function _gca { git commit -a @args } 
    Set-Alias -Force -Name gca -Value _gca

    function _gcam { git commit -am @args } 
    Set-Alias -Force -Name gcam -Value _gcam

    function _ga { git add @args } 
    Set-Alias -Force -Name ga -Value _ga

    function _gb { git branch @args } 
    Set-Alias -Force -Name gb -Value _gb

    function _gp { git push @args } 
    Set-Alias -Force -Name gp -Value _gp

    function _gpl { git pull @args } 
    Set-Alias -Force -Name gpl -Value _gpl

    function _gsw { git switch @args } 
    Set-Alias -Force -Name gsw -Value _gsw

    function _gch { git checkout @args } 
    Set-Alias -Force -Name gch -Value _gch

    function _gr { git restore @args } 
    Set-Alias -Force -Name gr -Value _gr

    function _grm { git rm @args }
    Set-Alias -Force -Name grm -Value _grm


    function _reporoot { git rev-parse --show-toplevel }
    Set-Alias -Force -Name reporoot -Value _reporoot

    if (Get-Command "gh" -ErrorAction Ignore) {
        function _ghclone { gh repo clone $args }
        Set-Alias -Force -Name clone -Value _ghclone
    } else {
        function _gitclone { git clone "https://github.com/jharrisong830/$args.git"}
        Set-Alias -Force -Name clone -Value _gitclone
    }
}

# setting common aliases
function _ll { Get-ChildItem @args } 
Set-Alias -Force -Name ll -Value _ll

function _la { Get-ChildItem @args } 
Set-Alias -Force -Name la -Value _la

function _lla { Get-ChildItem @args } 
Set-Alias -Force -Name lla -Value _lla

function _lal { Get-ChildItem @args } 
Set-Alias -Force -Name lal -Value _lal

function _win-fresh {
    if (Get-Command "winget" -ErrorAction Ignore) {
        winget upgrade --all
    }
    if (Get-Command "scoop" -ErrorAction Ignore) {
        scoop update * && scoop cleanup *
    }
}
Set-Alias -Force -Name win-fresh -Value _win-fresh
