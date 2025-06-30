param(
    [Parameter(Position = 0)]
    [ValidateSet("githubProject", "ls", "exec")]
    [string]$comando,

    [string]$path,
    [string]$comandoExec
)

function MudarDiretorio {
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
    Write-Host "Uso:"
    Write-Host "  .\cli.ps1 cd <path>"
    Write-Host "  .\cli.ps1 ls"
    Write-Host "  .\cli.ps1 exec <comando>"
    exit 1
}

switch ($comando) {
    "githubProject" { MudarDiretorio -Path $path }
}



# SIG # Begin signature block
# MIII5QYJKoZIhvcNAQcCoIII1jCCCNICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUf3zPdEpjExlfJ7PQ0y2z1rtH
# 1i2gggZIMIIGRDCCBSygAwIBAgITHgAAH9p7juDORnr5AQAAAAAf2jANBgkqhkiG
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
# FTAjBgkqhkiG9w0BCQQxFgQUCrj+ju5uEmD4c07T3DlLef6/RT8wDQYJKoZIhvcN
# AQEBBQAEggEAcddqeUcMOqdQHyWxB+tuS1qc3jlMhlZ8KUvAu/rxOV9QcR9J+U2g
# 8fWazSenvQ2/GaBgg4ebBtaxgnoQa7YqtECZ6CYA+6NNO1UqNArjqjqLvCLRhSVs
# 1JYs0fhMYT3F10+lDquwEQvOukjrfJkQkHTWJfgfxPgoOgvM3RvZ8CUiSNXX6AxE
# kAJKHR6ivz2k2o95VYM8QlY/JZ1/R3LJHL8NohM/s1TK7uZoShjxzYgot/IiEHJL
# o1lDA/246OW3tUh7LIt/XJ51vVArzucjl+pqyTHZ3j7De7eg5W5JNmkn+cDNxLCk
# 5HN1Cll7PHSoWv2+4VqauymuiSHAp+ZQiA==
# SIG # End signature block
