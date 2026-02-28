## Remote Server: Windows

```Powershell
# 安裝選用功能
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# 啟動服務並設為自動啟動
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# check

Get-Service -Name sshd

```

- Status: Running。

## SSH key

```

```
