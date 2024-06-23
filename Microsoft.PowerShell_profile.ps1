Set-PSReadLineOption -PredictionSource None # disable suggestions
Clear-Host # get rid of the version message

$ESC = [char]27 # usage for color: $ESC[<colorcode>m

function prompt {
    "$ESC[31m$env:USERNAME$ESC[0m @ $ESC[32m$env:COMPUTERNAME$ESC[0m: $ESC[34m$(Split-Path -Path $pwd -Leaf)$ESC[0m > "
}

if (Test-Path -Path "C:\Users\johng\.jdks\jdk-21.0.3+9") { # adding specific jdk to path (for java, javac, etc.)
    $env:PATH += ";C:\Users\johng\.jdks\jdk-21.0.3+9\bin"
}

if (Test-Path -Path "C:\Users\johng\AppData\Local\Android\Sdk") { # android studio for react native
    $env:ANDROID_HOME = "C:\Users\johng\AppData\Local\Android\Sdk" # create ANDROID_HOME env variable
    if (Test-Path -Path "C:\Users\johng\AppData\Local\Android\Sdk\platform-tools") { # add platform tools to path
        $env:PATH += "C:\Users\johng\AppData\Local\Android\Sdk\platform-tools"
    }
}
