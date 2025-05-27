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
