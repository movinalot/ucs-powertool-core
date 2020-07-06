

  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [Cisco.Ucs.UcsHandle[]] $Ucs
  )
  Process
  {
     Foreach ($u in $Ucs)
     {
       $sp = @(Get-UcsServiceProfile -Ucs $u -Type instance)
       $spMap = @{ }
       Write-Verbose "Fetching service profile instances"
       $sp | % { $spMap[$_.Dn] = $_ }


       $pnMap = @{ }
       Write-Verbose "Fetching processing nodes"
       Get-UcsBlade -Ucs $u | % { $pnMap[$_.Dn] = $_ }   
       Get-UcsRackUnit -Ucs $u | % { $pnMap[$_.Dn] = $_ }

       Write-Verbose "Fetching PN's management interfaces"
       $mgmtIf = $pnMap.values | Get-UcsMgmtController -Subject blade | Get-UcsMgmtIf -Subject blade -AdminState enable | ? { $_.ExtIp -ne "0.0.0.0" }
       $mgmtIfMap = @{ }
       Foreach ($mgmtIfDn in ($mgmtIf | select -ExpandProperty Dn | Get-Unique))
       {
         $mgmtIfMap[$mgmtIfDn -replace "/mgmt/if-[^/]*$",""] = $mgmtIf | ? { $_.Dn -eq $mgmtIfDn }
       }
       $mgmtIfDn = $mgmtIfMap.keys

       Write-Verbose "Fetching SP's Static CIMC IPs"
       $spStaticIpMap = @{ }
       $sp | Get-UcsVnicIpV4StaticAddr -LimitScope | % { $spStaticIpMap[$_.Dn -replace "/ipv4-static-addr$",""] = $_ }
       $spStaticIpDn = $spStaticIpMap.keys

       Write-Verbose "Fetching SP's Pooled CIMC IPs"
       $spDynamicIpMap = @{ }
       $sp | Get-UcsVnicIpV4PooledAddr -LimitScope | ? { $_.Addr -ne "0.0.0.0" } | % { $spDynamicIpMap[$_.Dn -replace "/ipv4-pooled-addr$",""] = $_ }
       $spDynamicIpDn = $spDynamicIpMap.keys

       Foreach ($spDn in ($spMap.keys | sort))
       {
         $ucsName = $u.Ucs
         $pnDn = $spMap[$spDn].PnDn
         $mgmtIfIp=""
         $spStaticIp = ""
         $spDynamicIp = ""
         if ($mgmtIfDn -contains $pnDn)
         {
           $mgmtIfIp = [string]::join(';', ($mgmtIfMap[$pnDn] | Select -ExpandProperty ExtIp)) 
         }
         if ($pnDn -ne "")
         {
           $pnMap.remove($pnDn)
         }
         if ($spStaticIpDn -contains $spDn)
         {
            $spStaticIp = $spStaticIpMap[$spDn].Addr
         }
         if ($spDynamicIpDn -contains $spDn)
         {
            $spDynamicIp = $spDynamicIpMap[$spDn].Addr
         }
         New-Object PSObject -Property @{
           "Ucs" = $ucsName
           "SpDn" = $spDn
           "PnDn" = $pnDn
           "SpCimcStaticIp" = $spStaticIp
           "SpCimcDynamicIp" = $spDynamicIp
           "PnCimcIp" = $mgmtIfIp
         } | Select-Object Ucs,SpDn,PnDn,SpCimcStaticIp,SpCimcDynamicIp,PnCimcIp
       }

       Foreach ($pnDn in ($pnMap.keys | sort))
       {
         $ucsName = $u.Ucs
         $mgmtIfIp=""
         if ($mgmtIfDn -contains $pnDn)
         {
           $mgmtIfIp = [string]::join(';', ($mgmtIfMap[$pnDn] | Select -ExpandProperty ExtIp)) 
         }
         New-Object PSObject -Property @{
           "Ucs" = $ucsName
           "SpDn" = ""
           "PnDn" = $pnDn
           "SpCimcStaticIp" = ""
           "SpCimcDynamicIp" = ""
           "PnCimcIp" = $mgmtIfIp
         } | Select-Object Ucs,SpDn,PnDn,SpCimcStaticIp,SpCimcDynamicIp,PnCimcIp
       }
    }
  }



# SIG # Begin signature block
# MIIY7wYJKoZIhvcNAQcCoIIY4DCCGNwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAiAuMO4UHGFiez
# SNqxldpHMvE0S8P7qF2d8gb1b7DYsaCCE08wggQVMIIC/aADAgECAgsEAAAAAAEx
# icZQBDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3Qg
# Q0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2ln
# bjAeFw0xMTA4MDIxMDAwMDBaFw0yOTAzMjkxMDAwMDBaMFsxCzAJBgNVBAYTAkJF
# MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
# IFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAtIEcyMIIBIjANBgkqhkiG9w0BAQEF
# AAOCAQ8AMIIBCgKCAQEAqpuOw6sRUSUBtpaU4k/YwQj2RiPZRcWVl1urGr/SbFfJ
# MwYfoA/GPH5TSHq/nYeer+7DjEfhQuzj46FKbAwXxKbBuc1b8R5EiY7+C94hWBPu
# TcjFZwscsrPxNHaRossHbTfFoEcmAhWkkJGpeZ7X61edK3wi2BTX8QceeCI2a3d5
# r6/5f45O4bUIMf3q7UtxYowj8QM5j0R5tnYDV56tLwhG3NKMvPSOdM7IaGlRdhGL
# D10kWxlUPSbMQI2CJxtZIH1Z9pOAjvgqOP1roEBlH1d2zFuOBE8sqNuEUBNPxtyL
# ufjdaUyI65x7MCb8eli7WbwUcpKBV7d2ydiACoBuCQIDAQABo4HoMIHlMA4GA1Ud
# DwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBSSIadKlV1k
# sJu0HuYAN0fmnUErTDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYm
# aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wNgYDVR0fBC8w
# LTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLm5ldC9yb290LXIzLmNybDAf
# BgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOC
# AQEABFaCSnzQzsm/NmbRvjWek2yX6AbOMRhZ+WxBX4AuwEIluBjH/NSxN8RooM8o
# agN0S2OXhXdhO9cv4/W9M6KSfREfnops7yyw9GKNNnPRFjbxvF7stICYePzSdnno
# 4SGU4B/EouGqZ9uznHPlQCLPOc7b5neVp7uyy/YZhp2fyNSYBbJxb051rvE9ZGo7
# Xk5GpipdCJLxo/MddL9iDSOMXCo4ldLA1c3PiNofKLW6gWlkKrWmotVzr9xG2wSu
# kdduxZi61EfEVnSAR3hYjL7vK/3sbL/RlPe/UOB74JD9IBh4GCJdCC6MHKCX8x2Z
# faOdkdMGRE4EbnocIOM28LZQuTCCBMYwggOuoAMCAQICDCRUuH8eFFOtN/qheDAN
# BgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2ln
# biBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBT
# SEEyNTYgLSBHMjAeFw0xODAyMTkwMDAwMDBaFw0yOTAzMTgxMDAwMDBaMDsxOTA3
# BgNVBAMMMEdsb2JhbFNpZ24gVFNBIGZvciBNUyBBdXRoZW50aWNvZGUgYWR2YW5j
# ZWQgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANl4YaGWrhL/
# o/8n9kRge2pWLWfjX58xkipI7fkFhA5tTiJWytiZl45pyp97DwjIKito0ShhK5/k
# Ju66uPew7F5qG+JYtbS9HQntzeg91Gb/viIibTYmzxF4l+lVACjD6TdOvRnlF4RI
# shwhrexz0vOop+lf6DXOhROnIpusgun+8V/EElqx9wxA5tKg4E1o0O0MDBAdjwVf
# ZFX5uyhHBgzYBj83wyY2JYx7DyeIXDgxpQH2XmTeg8AUXODn0l7MjeojgBkqs2Iu
# YMeqZ9azQO5Sf1YM79kF15UgXYUVQM9ekZVRnkYaF5G+wcAHdbJL9za6xVRsX4ob
# +w0oYciJ8BUCAwEAAaOCAagwggGkMA4GA1UdDwEB/wQEAwIHgDBMBgNVHSAERTBD
# MEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
# aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5j
# b20vZ3MvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3JsMIGYBggrBgEFBQcBAQSBizCB
# iDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
# cnQvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3J0MDwGCCsGAQUFBzABhjBodHRwOi8v
# b2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3N0aW1lc3RhbXBpbmdzaGEyZzIwHQYDVR0O
# BBYEFNSHuI3m5UA8nVoGY8ZFhNnduxzDMB8GA1UdIwQYMBaAFJIhp0qVXWSwm7Qe
# 5gA3R+adQStMMA0GCSqGSIb3DQEBCwUAA4IBAQAkclClDLxACabB9NWCak5BX87H
# iDnT5Hz5Imw4eLj0uvdr4STrnXzNSKyL7LV2TI/cgmkIlue64We28Ka/GAhC4evN
# GVg5pRFhI9YZ1wDpu9L5X0H7BD7+iiBgDNFPI1oZGhjv2Mbe1l9UoXqT4bZ3hcD7
# sUbECa4vU/uVnI4m4krkxOY8Ne+6xtm5xc3NB5tjuz0PYbxVfCMQtYyKo9JoRbFA
# uqDdPBsVQLhJeG/llMBtVks89hIq1IXzSBMF4bswRQpBt3ySbr5OkmCCyltk5lXT
# 0gfenV+boQHtm/DDXbsZ8BgMmqAc6WoICz3pZpendR4PvyjXCSMN4hb6uvM0MIIF
# MDCCBBigAwIBAgIQBAkYG1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0BAQsFADBlMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3Qg
# Q0EwHhcNMTMxMDIyMTIwMDAwWhcNMjgxMDIyMTIwMDAwWjByMQswCQYDVQQGEwJV
# UzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQu
# Y29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWdu
# aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+NOzHH8OEa9n
# dwfTCzFJGc/Q+0WZsTrbRPV/5aid2zLXcep2nQUut4/6kkPApfmJ1DcZ17aq8JyG
# pdglrA55KDp+6dFn08b7KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0sSgmuyRpwsJS
# 8hRniolF1C2ho+mILCCVrhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6scKKrzn/pfMuS
# oeU7MRzP6vIK5Fe7SrXpdOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4TzrGdOtcT3jNEg
# JSPrCGQ+UpbB8g8S9MWOD8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg0A9kczyen6Yz
# qf0Z3yWT0QIDAQABo4IBzTCCAckwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8B
# Af8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMweQYIKwYBBQUHAQEEbTBrMCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKG
# N2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJv
# b3RDQS5jcnQwgYEGA1UdHwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0
# LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaGNGh0dHA6Ly9j
# cmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwTwYD
# VR0gBEgwRjA4BgpghkgBhv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3
# LmRpZ2ljZXJ0LmNvbS9DUFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYEFFrEuXsqCqOl
# 6nEDwGD5LfZldQ5YMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA0G
# CSqGSIb3DQEBCwUAA4IBAQA+7A1aJLPzItEVyCx8JSl2qB1dHC06GsTvMGHXfgtg
# /cM9D8Svi/3vKt8gVTew4fbRknUPUbRupY5a4l4kgU4QpO4/cY5jDhNLrddfRHnz
# NhQGivecRk5c/5CxGwcOkRX7uq+1UcKNJK4kxscnKqEpKBo6cSgCPC6Ro8AlEeKc
# FEehemhor5unXCBc2XGxDI+7qPjFEmifz0DLQESlE/DmZAwlCEIysjaKJAL+L3J+
# HNdJRZboWR3p+nRka7LrZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4GbT8aTEAb8B4H6
# i9r5gkn3Ym6hU/oSlBiFLpKR6mhsRDKyZqHnGKSaZFHvMIIFNDCCBBygAwIBAgIQ
# D2NcG1fgU7fI95cZu49i0jANBgkqhkiG9w0BAQsFADByMQswCQYDVQQGEwJVUzEV
# MBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
# MTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWduaW5n
# IENBMB4XDTE5MTEyOTAwMDAwMFoXDTIyMTIwNzEyMDAwMFowcTELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCkNhbGlmb3JuaWExETAPBgNVBAcTCFNhbiBKb3NlMRwwGgYD
# VQQKExNDSVNDTyBTWVNURU1TLCBJTkMuMRwwGgYDVQQDExNDSVNDTyBTWVNURU1T
# LCBJTkMuMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqsEvGzii5EVJ
# /A3QD6I9UTbiLANzg5WDqRoushmxa+uo1BekikoZH1L61I1Ra+7pv+Xvksik6k4a
# dmQ0ICevh9sIh1il3eXK43vBuSR1WD/SKwnTvFiEUAcx3v1KZZwRB8EGPEeo9CUJ
# c7X+OFPdAcBeACnqErbROX8ZNcENcK/E76Kco+2oxoP/ky/X1yWS8QrqQj3rNmqO
# Das+cqcnGs0fDSA9A57Z1tARA8XnpP+CEMyJnfe/aEDqTbzlyxcfOmzjgvb7KDg9
# V/Rh7gfbwVmLcSq52rxdmjkVgj6wHmmJa+SRpze1HyscOeq3INeXL/5enWRg+0sA
# xDqHi1/A/QIDAQABo4IBxTCCAcEwHwYDVR0jBBgwFoAUWsS5eyoKo6XqcQPAYPkt
# 9mV1DlgwHQYDVR0OBBYEFPmQmHiQ5o+PB0RdUhrZboeTlPcZMA4GA1UdDwEB/wQE
# AwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzB3BgNVHR8EcDBuMDWgM6Axhi9odHRw
# Oi8vY3JsMy5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDA1oDOg
# MYYvaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC1jcy1nMS5j
# cmwwTAYDVR0gBEUwQzA3BglghkgBhv1sAwEwKjAoBggrBgEFBQcCARYcaHR0cHM6
# Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAIBgZngQwBBAEwgYQGCCsGAQUFBwEBBHgw
# djAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tME4GCCsGAQUF
# BzAChkJodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRTSEEyQXNz
# dXJlZElEQ29kZVNpZ25pbmdDQS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0B
# AQsFAAOCAQEAXZNMcB8fxisL3Aze8r+ZfxpWm9OBi6r261yBJ1pRVFrlMSH6t4WH
# QgWWajRB1p/nrzPyEqYOX68y+QjFcY+CxZXUpyy2oTzavDBLrYJ1vhtSAg9hO2Z5
# 5DH8mrHg+Ydg+N0k4dlh3Sm0pBXgjVlaVPBnmL+apQhZxyNm+ptqRSyIbzVVyfD6
# lRNYIw4qwN5CvfrRsHcyqQhssV5ehuYaPrfSw8hZMcde5CLgF3cmzYCadyKvx77Z
# tqkO0SbIPcKP3eD8x6GcZiExELtFOLgdof9vaHK8REgUXpU/uuWsXmZ++zAlmdz3
# htUrenG8SQAxqxK2cXXVjFjJiCaGFTbdnDGCBPYwggTyAgEBMIGGMHIxCzAJBgNV
# BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
# Y2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2Rl
# IFNpZ25pbmcgQ0ECEA9jXBtX4FO3yPeXGbuPYtIwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgR9Zjl0/GPboQGx8fp8muP1tvdPwSWbT+/7fEI03LraYwDQYJKoZIhvcNAQEB
# BQAEggEAD+f5md9BnsA+3pvJvXLMyOwVztqF+pKtBO4SGSBJeNcKvPCZzanX+Tq9
# OsA3hEQ1wC/gKFiawpZPWpxu4whr/ShmwMvArl/EfGrbOXoWgxL++zVNtoNDcXQX
# SRGO/che02I0dNm1ejpTMugiMUAfd+UgBtDbgPl6Ton8RF0R9wno7DLKIGVWkXmI
# YJq8lHaPUAJiXZGjCxfLGaDoLNQs8ar47kchd9MO4mHhdxZmwWqfy/vUOd0kOc1Z
# zQKtJ38q3F7fQ1XEfue38l+2lGzPu3wdf//LPSbreNdZ9ch7gHhgCauEIV6GYZpA
# kKtAc/eoNvYtAn/X+mr6s5t07V8/6aGCArkwggK1BgkqhkiG9w0BCQYxggKmMIIC
# ogIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJYIZIAWUDBAIBBQCgggEMMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDcwMjIyMDIzOFowLwYJ
# KoZIhvcNAQkEMSIEIHDIDCJXnPZlnOvc8facsJWYVV78rzNMslZ30cYMrjgVMIGg
# BgsqhkiG9w0BCRACDDGBkDCBjTCBijCBhwQUPsdm1dTUcuIbHyFDUhwxt5DZS2gw
# bzBfpF0wWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQEFAASCAQC/kt9CqM9QWCEq1N44
# ftpWdl9A8LYHMZd346i0f2oNLfppkg3DUS/VIFsLWmzWEqHR0KcVZYWYAzWl7Z9t
# BgJZC4TD8ZS1sjURkRGXFLZQzb4387zkRzStcAC/yCYP3eBrCgPqd2oBde+kBp5t
# JyahJxXdq5skXLycMUZKE1J+DQcdnxUlx88pKWbialhlaY7TM0hi3RwixpoUppbH
# HJRrCufCkmUnNIG5Tz9+k4KEcY18CQjFdXt2nwBx4RA/zxMd2UPoywlQuHEQgK6o
# uvN56NeBl4N/PFl5kbM0uXtWlgFLnpcIa00rSq5ygVaFgImgiExLky4Y2PHJzGXR
# /55s
# SIG # End signature block
