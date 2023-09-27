#function to read jvm arguments
function readJvmProps($propFilePath)  {
    $jvmArgs = "";
    if ([System.IO.File]::Exists($propFilePath)) {
        foreach($line in (Get-Content $propFilePath)){
        $line = $line.trim()
            if (!$line.StartsWith("#")) {
                $jvmArgs += " "
                $jvmArgs += $line
            }
        }
    } 
    return $jvmArgs
}
#function to run a program
function runCommand($arg0, $arg1) {
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $arg0
    $startInfo.Arguments = $arg1
    #$startInfo.RedirectStandardOutput = $true
    $startInfo.UseShellExecute = $false
    #$startInfo.CreateNoWindow = $false

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start() | Out-Null
    #$result = $process.StandardOutput.ReadToEnd()
    $process.WaitForExit()
    return 
}
#$dt0 = Get-Date
# Get environment attributes:
$dbg=""
$javahome=""
$tmpdir=""
$pasoehome=""
$pasoebase=""

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
if ($dbg -ne "")  {
	write-output "scriptPath:  $scriptPath"
}
$Result = &  "$scriptPath\tcman.bat" env javahome tmpdir pid home base
$ii = 0
foreach ($s in $Result)
{
    if (!$s.StartsWith("debug: ")) {
        if ($ii -eq 0) {$javahome = $s}
        if ($ii -eq 1) {$tmpdir = $s}
        if ($ii -eq 2) {$pasoepid = $s}
        if ($ii -eq 3) {$pasoehome = $s}
        if ($ii -eq 4) {$pasoebase = $s}
        $ii += 1
    }
	
}

#Get Arguments
if ($dbg -ne "")  {
    write-output "arguments: $args"
}

#Find and check jars
$commonLib = "$pasoehome\common\lib"
$commonLibBase = "$pasoebase\common\lib"
$binDir = "$pasoehome\bin"


# Compose java command  
$javaCall = "$javahome\bin\java.exe" 
$jvmArgs = readJvmProps "$pasoebase\conf\localJvm.properties"

$argNum = 0;
$sw = "";
if( ($args.length -eq 0) -or ($args.length -eq 1) -or ($args[0] -eq "help" )  ) {
    $sw = "bogus";
}

$pwind = -1;
while ($argNum -lt $args.length)
{
  $arg = $args[$argNum]
  if( $arg -eq "-password" ) {
    $pwind = $argNum + 1;
  }
  $argNum = $argNum + 1;
}
if ($dbg -ne "")  {
    write-output "commonLib: $commonLib/*"
    write-output "args: $args"
    write-output "pasoebase: $pasoebase"
}

if ($pwind -lt 0 -and $sw -eq "" ) {
    $sw = Read-Host -assecurestring "Password"
    $sw = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sw))
}

$logger = "org.apache.commons.logging.impl.NoOpLog"  
$logbackFile ="$pasoebase\conf\logging-oesectool.xml"

$class = "com.progress.appserv.util.sectool.PasoeSectoolService" 
$arguments = "$jvmArgs -cp ""$commonLibBase/*;$commonLib/*"" -Dpasoebase=$pasoebase -Dsw=$sw -Dorg.apache.cxf.Logger=$logger -Dlogback.configurationFile=$logbackFile $class $args"
#$dt1 = Get-Date
runCommand $javaCall $arguments
#$dt2 = Get-Date
#$diff01= New-TimeSpan -Start $dt0 -End $dt1
#$diff12= New-TimeSpan -Start $dt1 -End $dt2
#write-output "DDDDDDDDDDDDDD1 dt0-1 = $diff01"
#write-output "DDDDDDDDDDDDDD1 dt1-2 = $diff12"


# SIG # Begin signature block
# MIIq4wYJKoZIhvcNAQcCoIIq1DCCKtACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVfAgcugMZ6QHstJt5/J6OiwF
# IVCggiT7MIIETjCCAzagAwIBAgINAe5fFp3/lzUrZGXWajANBgkqhkiG9w0BAQsF
# ADBXMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4G
# A1UECxMHUm9vdCBDQTEbMBkGA1UEAxMSR2xvYmFsU2lnbiBSb290IENBMB4XDTE4
# MDkxOTAwMDAwMFoXDTI4MDEyODEyMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2ln
# biBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkds
# b2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
# Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr
# 9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkN
# c96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQ
# u7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWy
# n3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7p
# g5NxdsZphYIXAgMBAAGjggEiMIIBHjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
# BAUwAwEB/zAdBgNVHQ4EFgQUj/BLf6guRSSuTVD6Y5qL3uLdG7wwHwYDVR0jBBgw
# FoAUYHtmGkUNl8qJUC99BM00qP/8/UswPQYIKwYBBQUHAQEEMTAvMC0GCCsGAQUF
# BzABhiFodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9yb290cjEwMwYDVR0fBCww
# KjAooCagJIYiaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LmNybDBHBgNV
# HSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFs
# c2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcNAQELBQADggEBACNw6c/ivvVZ
# rpRCb8RDM6rNPzq5ZBfyYgZLSPFAiAYXof6r0V88xjPy847dHx0+zBpgmYILrMf8
# fpqHKqV9D6ZX7qw7aoXW3r1AY/itpsiIsBL89kHfDwmXHjjqU5++BfQ+6tOfUBJ2
# vgmLwgtIfR4uUfaNU9OrH0Abio7tfftPeVZwXwzTjhuzp3ANNyuXlava4BJrHEDO
# xcd+7cJiWOx37XMiwor1hkOIreoTbv3Y/kIvuX1erRjvlJDKPSerJpSZdcfL03v3
# ykzTr1EhkluEfSufFT90y1HonoMOFm8b50bOI7355KKL0jlrqnkckSziYSQtjipI
# cJDEHsXo4HAwggWiMIIEiqADAgECAhB4AxhCRXCKQc9vAbjutKlUMA0GCSqGSIb3
# DQEBDAUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYD
# VQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTIwMDcyODAw
# MDAwMFoXDTI5MDMxODAwMDAwMFowUzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
# b2JhbFNpZ24gbnYtc2ExKTAnBgNVBAMTIEdsb2JhbFNpZ24gQ29kZSBTaWduaW5n
# IFJvb3QgUjQ1MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAti3FMN16
# 6KuQPQNysDpLmRZhsuX/pWcdNxzlfuyTg6qE9aNDm5hFirhjV12bAIgEJen4aJJL
# gthLyUoD86h/ao+KYSe9oUTQ/fU/IsKjT5GNswWyKIKRXftZiAULlwbCmPgspzMk
# 7lA6QczwoLB7HU3SqFg4lunf+RuRu4sQLNLHQx2iCXShgK975jMKDFlrjrz0q1qX
# e3+uVfuE8ID+hEzX4rq9xHWhb71hEHREspgH4nSr/2jcbCY+6R/l4ASHrTDTDI0D
# fFW4FnBcJHggJetnZ4iruk40mGtwEd44ytS+ocCc4d8eAgHYO+FnQ4S2z/x0ty+E
# o7+6CTc9Z2yxRVwZYatBg/WsHet3DUZHc86/vZWV7Z0riBD++ljop1fhs8+oWukH
# JZsSxJ6Acj2T3IyU3ztE5iaA/NLDA/CMDNJF1i7nj5ie5gTuQm5nfkIWcWLnBPlg
# xmShtpyBIU4rxm1olIbGmXRzZzF6kfLUjHlufKa7fkZvTcWFEivPmiJECKiFN84H
# YVcGFxIkwMQxc6GYNVdHfhA6RdktpFGQmKmgBzfEZRqqHGsWd/enl+w/GTCZbzH7
# 6kCy59LE+snQ8FB2dFn6jW0XMr746X4D9OeHdZrUSpEshQMTAitCgPKJajbPyEyg
# zp74y42tFqfT3tWbGKfGkjrxgmPxLg4kZN8CAwEAAaOCAXcwggFzMA4GA1UdDwEB
# /wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDAzAPBgNVHRMBAf8EBTADAQH/MB0G
# A1UdDgQWBBQfAL9GgAr8eDm3pbRD2VZQu86WOzAfBgNVHSMEGDAWgBSP8Et/qC5F
# JK5NUPpjmove4t0bvDB6BggrBgEFBQcBAQRuMGwwLQYIKwYBBQUHMAGGIWh0dHA6
# Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA7BggrBgEFBQcwAoYvaHR0cDov
# L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1yMy5jcnQwNgYDVR0f
# BC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNy
# bDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cu
# Z2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcNAQEMBQADggEBAKz3
# zBWLMHmoHQsoiBkJ1xx//oa9e1ozbg1nDnti2eEYXLC9E10dI645UHY3qkT9XwEj
# WYZWTMytvGQTFDCkIKjgP+icctx+89gMI7qoLao89uyfhzEHZfU5p1GCdeHyL5f2
# 0eFlloNk/qEdUfu1JJv10ndpvIUsXPpYd9Gup7EL4tZ3u6m0NEqpbz308w2VXeb5
# ekWwJRcxLtv3D2jmgx+p9+XUnZiM02FLL8Mofnrekw60faAKbZLEtGY/fadY7qz3
# 7MMIAas4/AocqcWXsojICQIZ9lyaGvFNbDDUswarAGBIDXirzxetkpNiIHd1bL3I
# MrTcTevZ38GQlim9wX8wggYaMIIEAqADAgECAgx3ewOGWtlG+YZJs6IwDQYJKoZI
# hvcNAQELBQAwWTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
# c2ExLzAtBgNVBAMTJkdsb2JhbFNpZ24gR0NDIFI0NSBDb2RlU2lnbmluZyBDQSAy
# MDIwMB4XDTIxMDQwODE3MjIwN1oXDTIyMDEwOTE5MjAzNVowgYcxCzAJBgNVBAYT
# AlVTMRYwFAYDVQQIEw1NYXNzYWNodXNldHRzMRAwDgYDVQQHEwdCZWRmb3JkMSYw
# JAYDVQQKEx1Qcm9ncmVzcyBTb2Z0d2FyZSBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMd
# UHJvZ3Jlc3MgU29mdHdhcmUgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQDXzrgllexLM78hluSyPx5scM4CwDlWcRD9orIclbfSvWc+
# kQ7epeIfRAaUSey3BPggExW2JW1BpvY6irckK+xKBDvbHUia7fbK4TfMhPQfXHox
# UvPHVYXa7a+mbfZxW6OVTaWNyGOou54ddlfekKuXgEN8+kUn6QIIJBE0WhhaxJTa
# uaL6L5lRvPcEhAe4pjwAys4lWs+3gRZ0CIdUbtgAsDl9tlpZ6qhK5irrxivdltfA
# d06tc+RswnVBhQkmmP37W7woO8yc+901o6YBwUQ/2EN8IzAIm4zt9iTZc8hi1U8e
# DEZnsoa51Yqc0nhrq23rukCxY4L+5p6MzvexTb65AgMBAAGjggGxMIIBrTAOBgNV
# HQ8BAf8EBAMCB4AwgZsGCCsGAQUFBwEBBIGOMIGLMEoGCCsGAQUFBzAChj5odHRw
# Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I0NWNvZGVzaWdu
# Y2EyMDIwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
# b20vZ3NnY2NyNDVjb2Rlc2lnbmNhMjAyMDBWBgNVHSAETzBNMEEGCSsGAQQBoDIB
# MjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBv
# c2l0b3J5LzAIBgZngQwBBAEwCQYDVR0TBAIwADBFBgNVHR8EPjA8MDqgOKA2hjRo
# dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjQ1Y29kZXNpZ25jYTIwMjAu
# Y3JsMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB8GA1UdIwQYMBaAFNqzjcAkkKNrd9MM
# oFndIWdkdgt4MB0GA1UdDgQWBBQtxwoxbz41bk5nLyhhzuMcNykSfDANBgkqhkiG
# 9w0BAQsFAAOCAgEAr7EXhVHzcJs7ghNPgJMBJgvJLz4Bxsd2ZFfwSgW6hq4mN3Jx
# ZeLQAOPGCJS2WshFphhR+I0x6GlElkLcpe/iluQu3mkYZCI1bxahVfaXgbjND1OZ
# XfDhfIEacnaCF7D/MFysEv3zK7pVMT5ogHTeyjUrNmzG9nwhO2HAfoI6KA52sYDF
# 0eyKPWhkuFV/sy8y8U+wE8q0loI5185tPjp00S7SuOyeGKLBK/aDTIjuve5mcm1h
# GOSfg41S6EvBqu2RBARk+zGwSQbt/VD9ITVlbfFu2tUhgXLHj2FhPtWdfyx9sukK
# BfX9Kprpv7rWbtFKxytJeINNnwni21jwdz+NhSSYtLRm76VK7GCRiA4D8P6onLiu
# ZI1ULqOLhX/dAsYgCiaRxnEj8rJWA3Q17WdZ7egaNobvHaHXvHBFG+foNFSDamxm
# Ggry8nlRMrSv8noRqUb07LQo01RYR4KCKoXzFGENE5jc15T6ZvM1qvd0KH/6GUog
# psukCvKtRY4bo/eWzp1L43vKpm2hF8/xg/h2ELvyWwT31xTxd8U4fL8dALflbW0H
# eGAUi0/JdZSYkmhiKPDwSDzBLSuN3xTdGMDd4hZT6ygqzpwwApkJvOj0yrn9/BGu
# Z72IhQo6tTN1uVKQG5Rw9TQSaEURKJEmO3qCX7sPSvXy5Ta2qzeYtTp8MzYwggbm
# MIIEzqADAgECAhB3vQ4DobcI+FSrBnIQ2QRHMA0GCSqGSIb3DQEBCwUAMFMxCzAJ
# BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSkwJwYDVQQDEyBH
# bG9iYWxTaWduIENvZGUgU2lnbmluZyBSb290IFI0NTAeFw0yMDA3MjgwMDAwMDBa
# Fw0zMDA3MjgwMDAwMDBaMFkxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
# aWduIG52LXNhMS8wLQYDVQQDEyZHbG9iYWxTaWduIEdDQyBSNDUgQ29kZVNpZ25p
# bmcgQ0EgMjAyMDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANZCTfnj
# T8Yj9GwdgaYw90g9z9DljeUgIpYHRDVdBs8PHXBg5iZU+lMjYAKoXwIC947Jbj2p
# eAW9jvVPGSSZfM8RFpsfe2vSo3toZXer2LEsP9NyBjJcW6xQZywlTVYGNvzBYkx9
# fYYWlZpdVLpQ0LB/okQZ6dZubD4Twp8R1F80W1FoMWMK+FvQ3rpZXzGviWg4QD4I
# 6FNnTmO2IY7v3Y2FQVWeHLw33JWgxHGnHxulSW4KIFl+iaNYFZcAJWnf3sJqUGVO
# U/troZ8YHooOX1ReveBbz/IMBNLeCKEQJvey83ouwo6WwT/Opdr0WSiMN2WhMZYL
# jqR2dxVJhGaCJedDCndSsZlRQv+hst2c0twY2cGGqUAdQZdihryo/6LHYxcG/WZ6
# NpQBIIl4H5D0e6lSTmpPVAYqgK+ex1BC+mUK4wH0sW6sDqjjgRmoOMieAyiGpHSn
# R5V+cloqexVqHMRp5rC+QBmZy9J9VU4inBDgoVvDsy56i8Te8UsfjCh5MEV/bBO2
# PSz/LUqKKuwoDy3K1JyYikptWjYsL9+6y+JBSgh3GIitNWGUEvOkcuvuNp6nUSeR
# PPeiGsz8h+WX4VGHaekizIPAtw9FbAfhQ0/UjErOz2OxtaQQevkNDCiwazT+IWgn
# b+z4+iaEW3VCzYkmeVmda6tjcWKQJQ0IIPH/AgMBAAGjggGuMIIBqjAOBgNVHQ8B
# Af8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwMwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAdBgNVHQ4EFgQU2rONwCSQo2t30wygWd0hZ2R2C3gwHwYDVR0jBBgwFoAUHwC/
# RoAK/Hg5t6W0Q9lWULvOljswgZMGCCsGAQUFBwEBBIGGMIGDMDkGCCsGAQUFBzAB
# hi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jb2Rlc2lnbmluZ3Jvb3RyNDUw
# RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0
# L2NvZGVzaWduaW5ncm9vdHI0NS5jcnQwQQYDVR0fBDowODA2oDSgMoYwaHR0cDov
# L2NybC5nbG9iYWxzaWduLmNvbS9jb2Rlc2lnbmluZ3Jvb3RyNDUuY3JsMFYGA1Ud
# IARPME0wQQYJKwYBBAGgMgEyMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmds
# b2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAgGBmeBDAEEATANBgkqhkiG9w0BAQsF
# AAOCAgEACIhyJsav+qxfBsCqjJDa0LLAopf/bhMyFlT9PvQwEZ+PmPmbUt3yohbu
# 2XiVppp8YbgEtfjry/RhETP2ZSW3EUKL2Glux/+VtIFDqX6uv4LWTcwRo4NxahBe
# GQWn52x/VvSoXMNOCa1Za7j5fqUuuPzeDsKg+7AE1BMbxyepuaotMTvPRkyd60zs
# vC6c8YejfzhpX0FAZ/ZTfepB7449+6nUEThG3zzr9s0ivRPN8OHm5TOgvjzkeNUb
# zCDyMHOwIhz2hNabXAAC4ShSS/8SS0Dq7rAaBgaehObn8NuERvtz2StCtslXNMcW
# wKbrIbmqDvf+28rrvBfLuGfr4z5P26mUhmRVyQkKwNkEcUoRS1pkw7x4eK1MRyZl
# B5nVzTZgoTNTs/Z7KtWJQDxxpav4mVn945uSS90FvQsMeAYrz1PYvRKaWyeGhT+R
# vuB4gHNU36cdZytqtq5NiYAkCFJwUPMB/0SuL5rg4UkI4eFb1zjRngqKnZQnm8qj
# udviNmrjb7lYYuA2eDYB+sGniXomU6Ncu9Ky64rLYwgv/h7zViniNZvY/+mlvW1L
# WSyJLC9Su7UpkNpDR7xy3bzZv4DB3LCrtEsdWDY3ZOub4YUXmimi/eYI0pL/oPh8
# 4emn0TCOXyZQK8ei4pd3iu/YTT4m65lAYPM8Zwy2CHIpNVOBNNwwggbsMIIE1KAD
# AgECAhAwD2+s3WaYdHypRjaneC25MA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkx
# HjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRy
# dXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xOTA1MDIwMDAwMDBa
# Fw0zODAxMTgyMzU5NTlaMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
# IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28g
# TGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBDQTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMgbAa/ZLH6ImX0BmD8gkL2c
# gCFUk7nPoD5T77NawHbWGgSlzkeDtevEzEk0y/NFZbn5p2QWJgn71TJSeS7JY8IT
# m7aGPwEFkmZvIavVcRB5h/RGKs3EWsnb111JTXJWD9zJ41OYOioe/M5YSdO/8zm7
# uaQjQqzQFcN/nqJc1zjxFrJw06PE37PFcqwuCnf8DZRSt/wflXMkPQEovA8NT7OR
# AY5unSd1VdEXOzQhe5cBlK9/gM/REQpXhMl/VuC9RpyCvpSdv7QgsGB+uE31DT/b
# 0OqFjIpWcdEtlEzIjDzTFKKcvSb/01Mgx2Bpm1gKVPQF5/0xrPnIhRfHuCkZpCkv
# RuPd25Ffnz82Pg4wZytGtzWvlr7aTGDMqLufDRTUGMQwmHSCIc9iVrUhcxIe/arK
# CFiHd6QV6xlV/9A5VC0m7kUaOm/N14Tw1/AoxU9kgwLU++Le8bwCKPRt2ieKBtKW
# h97oaw7wW33pdmmTIBxKlyx3GSuTlZicl57rjsF4VsZEJd8GEpoGLZ8DXv2DolNn
# yrH6jaFkyYiSWcuoRsDJ8qb/fVfbEnb6ikEk1Bv8cqUUotStQxykSYtBORQDHin6
# G6UirqXDTYLQjdprt9v3GEBXc/Bxo/tKfUU2wfeNgvq5yQ1TgH36tjlYMu9vGFCJ
# 10+dM70atZ2h3pVBeqeDAgMBAAGjggFaMIIBVjAfBgNVHSMEGDAWgBRTeb9aqitK
# z1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUGqH4YRkgD8NBd0UojtE1XwYSBFUwDgYD
# VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEwYDVR0lBAwwCgYIKwYB
# BQUHAwgwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6
# Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0
# aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9j
# cnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggr
# BgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwF
# AAOCAgEAbVSBpTNdFuG1U4GRdd8DejILLSWEEbKw2yp9KgX1vDsn9FqguUlZkCls
# Ycu1UNviffmfAO9Aw63T4uRW+VhBz/FC5RB9/7B0H4/GXAn5M17qoBwmWFzztBEP
# 1dXD4rzVWHi/SHbhRGdtj7BDEA+N5Pk4Yr8TAcWFo0zFzLJTMJWk1vSWVgi4zVx/
# AZa+clJqO0I3fBZ4OZOTlJux3LJtQW1nzclvkD1/RXLBGyPWwlWEZuSzxWYG9vPW
# S16toytCiiGS/qhvWiVwYoFzY16gu9jc10rTPa+DBjgSHSSHLeT8AtY+dwS8BDa1
# 53fLnC6NIxi5o8JHHfBd1qFzVwVomqfJN2Udvuq82EKDQwWli6YJ/9GhlKZOqj0J
# 9QVst9JkWtgqIsJLnfE5XkzeSD2bNJaaCV+O/fexUpHOP4n2HKG1qXUfcb9bQ11l
# PVCBbqvw0NP8srMftpmWJvQ8eYtcZMzN7iea5aDADHKHwW5NWtMe6vBE5jJvHOsX
# TpTDeGUgOw9Bqh/poUGd/rG4oGUqNODeqPk85sEwu8CgYyz8XBYAqNDEf+oRnR4G
# xqZtMl20OAkrSQeq/eww2vGnL8+3/frQo4TZJ577AWZ3uVYQ4SBuxq6x+ba6yDVd
# M3aO8XwgDCp3rrWiAoa6Ke60WgCxjKvj+QrJVF3UuWp0nr1IrpgwggcHMIIE76AD
# AgECAhEAjHegAI/00bDGPZ86SIONazANBgkqhkiG9w0BAQwFADB9MQswCQYDVQQG
# EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
# b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28g
# UlNBIFRpbWUgU3RhbXBpbmcgQ0EwHhcNMjAxMDIzMDAwMDAwWhcNMzIwMTIyMjM1
# OTU5WjCBhDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
# cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSww
# KgYDVQQDDCNTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIFNpZ25lciAjMjCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJGHSyyLwfEeoJ7TB8YBylKwvnl5
# XQlmBi0vNX27wPsn2kJqWRslTOrvQNaafjLIaoF9tFw+VhCBNToiNoz7+CAph6x0
# 0BtivD9khwJf78WA7wYc3F5Ok4e4mt5MB06FzHDFDXvsw9njl+nLGdtWRWzuSyBs
# yT5s/fCb8Sj4kZmq/FrBmoIgOrfv59a4JUnCORuHgTnLw7c6zZ9QBB8amaSAAk0d
# BahV021SgIPmbkilX8GJWGCK7/GszYdjGI50y4SHQWljgbz2H6p818FBzq2rdosg
# gNQtlQeNx/ULFx6a5daZaVHHTqadKW/neZMNMmNTrszGKYogwWDG8gIsxPnIIt/5
# J4Khg1HCvMmCGiGEspe81K9EHJaCIpUqhVSu8f0+SXR0/I6uP6Vy9MNaAapQpYt2
# lRtm6+/a35Qu2RrrTCd9TAX3+CNdxFfIJgV6/IEjX1QJOCpi1arK3+3PU6sf9kSc
# 1ZlZxVZkW/eOUg9m/Jg/RAYTZG7p4RVgUKWx7M+46MkLvsWE990Kndq8KWw9Vu2/
# eGe2W8heFBy5r4Qtd6L3OZU3b05/HMY8BNYxxX7vPehRfnGtJHQbLNz5fKrvwnZJ
# aGLVi/UD3759jg82dUZbk3bEg+6CviyuNxLxvFbD5K1Dw7dmll6UMvqg9quJUPrO
# oPMIgRrRRKfM97gxAgMBAAGjggF4MIIBdDAfBgNVHSMEGDAWgBQaofhhGSAPw0F3
# RSiO0TVfBhIEVTAdBgNVHQ4EFgQUaXU3e7udNUJOv1fTmtufAdGu3tAwDgYDVR0P
# AQH/BAQDAgbAMAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgw
# QAYDVR0gBDkwNzA1BgwrBgEEAbIxAQIBAwgwJTAjBggrBgEFBQcCARYXaHR0cHM6
# Ly9zZWN0aWdvLmNvbS9DUFMwRAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5z
# ZWN0aWdvLmNvbS9TZWN0aWdvUlNBVGltZVN0YW1waW5nQ0EuY3JsMHQGCCsGAQUF
# BwEBBGgwZjA/BggrBgEFBQcwAoYzaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0
# aWdvUlNBVGltZVN0YW1waW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEASgN4kEIz7Hsagwk2M5hV
# u51ABjBrRWrxlA4ZUP9bJV474TnEW7rplZA3N73f+2Ts5YK3lcxXVXBLTvSoh90i
# haZXu7ghJ9SgKjGUigchnoq9pxr1AhXLRFCZjOw+ugN3poICkMIuk6m+ITR1Y7ng
# LQ/PATfLjaL6uFqarqF6nhOTGVWPCZAu3+qIFxbradbhJb1FCJeA11QgKE/Ke7Oz
# pdIAsGA0ZcTjxcOl5LqFqnpp23WkPnlomjaLQ6421GFyPA6FYg2gXnDbZC8Bx8Gh
# xySUo7I8brJeotD6qNG4JRwW5sDVf2gaxGUpNSotiLzqrnTWgufAiLjhT3jwXMrA
# QFzCn9UyHCzaPKw29wZSmqNAMBewKRaZyaq3iEn36AslM7U/ba+fXwpW3xKxw+7O
# kXfoIBPpXCTH6kQLSuYThBxN6w21uIagMKeLoZ+0LMzAFiPJkeVCA0uAzuRN5ioB
# PsBehaAkoRdA1dvb55gQpPHqGRuAVPpHieiYgal1wA7f0GiUeaGgno62t0Jmy9nZ
# ay9N2N4+Mh4g5OycTUKNncczmYI3RNQmKSZAjngvue76L/Hxj/5QuHjdFJbeHA5w
# sCqFarFsaOkq5BArbiH903ydN+QqBtbD8ddo408HeYEIE/6yZF7psTzm0Hgjsgks
# 4iZivzupl1HMx0QygbKvz98xggVSMIIFTgIBATBpMFkxCzAJBgNVBAYTAkJFMRkw
# FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMS8wLQYDVQQDEyZHbG9iYWxTaWduIEdD
# QyBSNDUgQ29kZVNpZ25pbmcgQ0EgMjAyMAIMd3sDhlrZRvmGSbOiMAkGBSsOAwIa
# BQCgcDAQBgorBgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIB
# BDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU
# FQeigWMynfAqOt24strP6IjWBDwwDQYJKoZIhvcNAQEBBQAEggEA1bRHBFT3Jkhd
# zwuo+q8fwSVCK85cruNj4rXxUh0Vwoeu2s5fweY5lwUn3cbj2GfxGn784jZ/RBDt
# pXbB1KcBWdseyinz53mdw3WdTnIAIlfSO2xNn6wHi0C/2wNIUbPHwCtaJJKkjXFd
# XB9aoCvM0pfNNtf3hmctc4om486g2RBmbIfCNDRY6kMLBJoTdqXYDd17MoWPogvJ
# 5nEnoVA6flmh4KBxbiSYx2v113wP7Zo5C9jkdwGso5wnaIR48C3D6p6P3258Z0Cp
# 4a0UkaLblL+GXhwrihK4Ktr4pqltYqDIqENun4ocdRd0q38RaoPbfTWRZU+DTsQu
# 36Kugk1ZHqGCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCG
# SAFlAwQCAgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
# CQUxDxcNMjEwNzIyMTk0NjQwWjA/BgkqhkiG9w0BCQQxMgQwBuXixrxlRJvH0X6S
# xAgF1oHchBynZ78801jdspY7NPdwj+/ERkW3aKicn8V+qnr4MA0GCSqGSIb3DQEB
# AQUABIICAE6I7aJC2wrdqLgYMf1tDEpl5TGj9BSwKN/y7+wffEusUDb3tQoHhsZt
# BNoKlpLjMhmOraPldhlwnZln6JqKf/7DPWL8sXBl6JJN4di/xwE8XpZD9qB0HS20
# Ua+Z7Dx+BElcO5Y0kd30bfvZtZ2ZJ7gJ9bswic0Qala6CFwlZZ15EfTsxtAouwaT
# /OwtuhN4eSaPhEDVcwecvLw6IWY2/TkI7dWLxnnyps9l8EPzHpF9piA2Bw+KpNH3
# 0OhOxJdxBrvUvp3MzvUtLAdgf9bydeiAYwMAQVJ/yq0vmq3oHq5LMPqsyxQgJNDS
# XvGPq42M7wFlTYUDA4GSo8wRjuu/mOfGtJLWc6BHGm8H54wGRiVxMWLz64ezjqWA
# e+3bNahob1dfbXt0Ms5eq5KNDRAGgDDRJmTosI0KbLCA8fFjLPsurnt9LG78LqTU
# AJbSXT4iimzV380EnTK+8yFh+ZBTYzWCyVktgqedTgawxGMcCfJ+HQ9nKGVDltFW
# ZK9WuBMxXpu5s17wHOnGaRn5ysVx9+WEAewrMvGKMICCUHXwQTFrZiMrKaZU1lgJ
# Ztbf1LY+XpsR2qBszv5wUCCuOgaedajePWtXI8Wb3V9BVQPXE9Lpe192NX9oPH7a
# 2Mz2hjpsGSiT9oN8PQIceb70/uokhLHoYwzmZn1kILklQsfqF1gw
# SIG # End signature block
