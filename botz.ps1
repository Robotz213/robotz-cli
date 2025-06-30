param(
    [Parameter(Position = 0)]
    [ValidateSet("cdProject", "listProject", "mkProject")]
    [string]$comando,
    [string]$AdditionalParameter,
    [string]$type,
    [string]$projectName
)   
$githubPath = "C:\\Github"
$OsSystem = & python -c "import platform; print(platform.system())"
$githubPath = if ($OsSystem -eq "Windows") {
    "C:\\Github"
}
else {
    "$HOME/Github"
}

function ChangeDir {
    param([string]$Path)
    try {
        Set-Location -Path $Path
        Write-Host "Accessing projects folder in: $(Get-Location)" 
    }
    catch {
        Write-Host  "Project folders do not exist, creating: $githubPath"
        New-Item -Path $githubPath -ItemType Directory -Force | Out-Null
        Set-Location -Path $githubPath  
        Write-Host  "Created and accessed projects folder in: $(Get-Location)"
    }
}

function ListProjetosGithub {
    if (-Not (Test-Path $githubPath)) {
        Write-Host "A pasta $githubPath não existe."
        return
    }
    $repos = Get-ChildItem -Path $githubPath -Directory | Where-Object {
        Test-Path (Join-Path $_.FullName ".git")
    }
    $count = $repos.Count
    Write-Host "Foram encontrados $count projetos com .git na pasta $githubPath."
    foreach ($repo in $repos) {
        $gitDir = Join-Path $repo.FullName ".git"
        $configPath = Join-Path $gitDir "config"
        if (Test-Path $configPath) {
            $config = Get-Content $configPath
            $originLine = $config | Where-Object { $_ -match 'url\s*=\s*(.+)$' }
            if ($originLine -and ($originLine -match '/([^/]+?)(\.git)?$')) {
                Write-Host $matches[1]
                continue
            }
        }
        Write-Host $repo.Name
    }
}

function ExecutarComandoPersonalizado {
    param([string]$Comando)
    Invoke-Expression $Comando
}

if (-not $comando) {
    Write-Host "Usage:"
    Write-Host "  .\cli.ps1 cd <path>"
    Write-Host "  .\cli.ps1 ls"
    Write-Host "  .\cli.ps1 exec <comando>"
    exit 1
}


function CreateProject {
    param([string]$projectName)
    ChangeDir -Path $githubPath
    function CreateViteProject {
        param([string]$projectName)
        if (-Not $projectName) {
            Write-Host "Usage: .\cli.ps1 mkProject <projectName>"
            return
        }
        Invoke-Expression "npm create vite@latest $projectName -- --template vue-ts"
    }

    function CreatePoetryProject {
        param([string]$projectName)
        
        if (-Not $projectName) {
            Write-Host "Usage: .\cli.ps1 mkProject --type poetry <projectName>"
            return
        }
        Invoke-Expression "poetry new $projectName"

        Write-Host "Poetry project '$projectName' created successfully."
    }

    switch ($type) {
        "vite" { CreateViteProject -projectName $projectName }
        "poetry" { CreatePoetryProject -projectName $projectName }
        Default { Write-Host "Unknown project type: $type" }
    }


}

switch ($comando) {
    "cdProject" { ChangeDir -Path $githubPath }
    "listProject" { ListProjetosGithub }
    "mkProject" {
        if (-not $projectName) {
            Write-Host "Usage: .\cli.ps1 mkProject --type <type> <projectName>"
            return
        }
        CreateProject -projectName $projectName -type $type
    }
}



# SIG # Begin signature block
# MIII5QYJKoZIhvcNAQcCoIII1jCCCNICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU2LTIvI3kb88mdo8FcIbVnc97
# +rygggZIMIIGRDCCBSygAwIBAgITHgAAH9p7juDORnr5AQAAAAAf2jANBgkqhkiG
# 9w0BAQsFADBPMRgwFgYKCZImiZPyLGQBGRYIaW50cmFuZXQxEzARBgoJkiaJk/Is
# ZAEZFgNmbXYxHjAcBgNVBAMTFWZtdi1TUlYtQVNHQVJELURDMi1DQTAeFw0yNTA2
# MDIxNTAwNTVaFw0yNjA2MDIxNTAwNTVaMHAxGDAWBgoJkiaJk/IsZAEZFghpbnRy
# YW5ldDETMBEGCgmSJomT8ixkARkWA2ZtdjERMA8GA1UECxMIVVNVQVJJT1MxEzAR
# BgNVBAsTClQuSS4gLSBERVYxFzAVBgNVBAMTDk5pY2hvbGFzIFNpbHZhMIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxxE09XeKkYXPQlWJy0j1Olx/1eYA
# MUUn02eIbck6T19wg3gfAlsucColAG2KJcxVJQFdLYxLYrT1Qhlh7mtFMxAZ98Qj
# 7TKaicaTv02g7kUwleyO0ZPmoXTb09nWgy5Ly3MWjjRskVQcAOKUKLbi2+21qH0V
# kbtdgOwls6qkJsMpJgVQ93o7VkWG2xqrjcMC6HUaTk9qxxM3b2i4KtqqcPUudZCj
# 91ZDVZl0UbSb9wDGQ7tVKIaQq8aa/wwm3aX9wi0U2Mtwm13jwXYfoRYp5B0hIMod
# tdIuv/Yl+j7HBWA109V/+CjVtZxAA+UZdDOv7ukA7/FEWtuJme2FHJMI7QIDAQAB
# o4IC9jCCAvIwJQYJKwYBBAGCNxQCBBgeFgBDAG8AZABlAFMAaQBnAG4AaQBuAGcw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgeAMB0GA1UdDgQWBBRt
# 2vtgCoFhVsfjq8XL9yx/vIKGljAfBgNVHSMEGDAWgBQHujZf+/2B9+kUeELE3EIs
# MzGpbTCB2wYDVR0fBIHTMIHQMIHNoIHKoIHHhoHEbGRhcDovLy9DTj1mbXYtU1JW
# LUFTR0FSRC1EQzItQ0EsQ049U1JWLUFTR0FSRC1EQzIsQ049Q0RQLENOPVB1Ymxp
# YyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
# REM9Zm12LERDPWludHJhbmV0P2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFz
# ZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludDCB/QYIKwYBBQUHAQEE
# gfAwge0wgbUGCCsGAQUFBzAChoGobGRhcDovLy9DTj1mbXYtU1JWLUFTR0FSRC1E
# QzItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
# Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Zm12LERDPWludHJhbmV0P2NBQ2VydGlm
# aWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MDMG
# CCsGAQUFBzABhidodHRwOi8vU1JWLUFTR0FSRC1EQzIuZm12LmludHJhbmV0L29j
# c3AwNgYDVR0RBC8wLaArBgorBgEEAYI3FAIDoB0MG25pY2hvbGFzLnNpbHZhQGZt
# di5pbnRyYW5ldDBOBgkrBgEEAYI3GQIEQTA/oD0GCisGAQQBgjcZAgGgLwQtUy0x
# LTUtMjEtNjIzMTQyOTQxLTM4NTI4ODkxMjMtMTQyNDU1NDMxNy0xMTQyMA0GCSqG
# SIb3DQEBCwUAA4IBAQBQtWSonlNpVuWd6uqz0zeA2AGSeu2RW3NosuOYnx3V+Eh9
# wz5214FHgeQntfc34xRB3stjtUBNWn60lT99T/6Dj9094rq/0Xy4TqhUme4GoaiE
# gldQN4DVPP4Y8R2cay7MoqJDpyjc9aiJoOckm2fWixECB0waBQa24R96qu1yldVk
# OpUxamQDJ8PgXZnCLXsDsz/DGevLVvddY+X03e3KExuTHTlzP0QyhxvNB212XMYt
# foZIIB05D86dFfjDDh1g5ukmsGCWQlJECkTxalEM9bshtn9wzmbTBrMQePKqM0gN
# iAVhstnwwJoLDq8pdV61WAr6BkLJkv4bM77MdVwmMYICBzCCAgMCAQEwZjBPMRgw
# FgYKCZImiZPyLGQBGRYIaW50cmFuZXQxEzARBgoJkiaJk/IsZAEZFgNmbXYxHjAc
# BgNVBAMTFWZtdi1TUlYtQVNHQVJELURDMi1DQQITHgAAH9p7juDORnr5AQAAAAAf
# 2jAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG
# 9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIB
# FTAjBgkqhkiG9w0BCQQxFgQUs8SDvo7Fbo3BGokvLm7cRlEZgdowDQYJKoZIhvcN
# AQEBBQAEggEAo1mt7BXBRtHoV0ZawLOvYs2ytUVJJ4WvgZOKaxaBUt0GgosmrdfC
# AsFUHcWkp/RIR3Lm6KVIbLl2pNDVaaZDacIQIcbwhVeWmLtMR/NWnS+efjLQPplU
# Ife5zH5e8K1lYviTOnTqkdK8hImiyEI7Wl52t2tN6dKAdPLPhuxQ9yr1fySDH0Tp
# 1aMbHWITh1Hyv1zNCg9g8fwQnyMQF12zfLLGWC+HwQ7/Nd/WtLJMX+GNGLza2Kj0
# eHSobiteY1Y6HQY4kBzv/+nYlBjQ/xhAxtaeuqHTVLFK9Jgf8gCtJXv8zblMH82+
# KmUYUKaxU2BPwEh0afD62Mzy7GzJkkFVOQ==
# SIG # End signature block
