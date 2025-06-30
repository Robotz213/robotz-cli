param(
    [Parameter(Position = 0)]
    [ValidateSet("githubProject", "ls", "exec")]
    [string]$comando,

    [string]$path,
    [string]$comandoExec
)

function ChangeDir {
    $path = "C:\\Github"
    try {
        Set-Location -Path $path
        Write-Host utf8 "Accessing projects folder in: $(Get-Location)" 
    }
    catch {
        Write-Host  "Project folders do not exist, creating: $path"
        New-Item -Path $path -ItemType Directory -Force | Out-Null
        Set-Location -Path $path  
        Write-Host  "Created and accessed projects folder in: $(Get-Location)"
    }
}

function ListArquivos {
    Get-ChildItem
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

switch ($comando) {
    "githubProject" { ChangeDir -Path $path }
}



# SIG # Begin signature block
# MIII5QYJKoZIhvcNAQcCoIII1jCCCNICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU2j8wQ4B2XZx48EY6TeE0kjfc
# KOKgggZIMIIGRDCCBSygAwIBAgITHgAAH9p7juDORnr5AQAAAAAf2jANBgkqhkiG
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
# FTAjBgkqhkiG9w0BCQQxFgQUC5bo6aMS6nM3pNojiIVndtUsTxQwDQYJKoZIhvcN
# AQEBBQAEggEAQbVKP6VDWLlkecNqJciNG/oNN1+qfcFwR78SLBN/NqlcZeMeJdSM
# rRcBdORIkVDxyAvfMP4TsqTLG9WZk3vV3aZ6WMFlhQf4rEzmtkUz1l6VP2nQbZ3+
# BW2AEttvk7PNTcT8p3bcJwSbIG2yqbeKmFkVkmTuKMALEjW7mffdBaxTyk1+IBNw
# XqpFDn7QLHi2hm8/U0HSIAP6/dD5V8cJGDsr2PjEQnM1S669H4d3/xaYAvfnBWz2
# gmzQ4KszcbBAUDiy+OejxiAcU6Qdlicm9waOFwICx3Ry94AxypuGIEUBDV1sAokb
# uRCvcdjQJDpKjzwwSd49G6DzkPnGIHFUzQ==
# SIG # End signature block
