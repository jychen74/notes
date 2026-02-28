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

## SSH key setting

```Powershell

# 1. 建立設定目錄
$sshDir = "C:\ProgramData\ssh"
if (!(Test-Path $sshDir)) { New-Item -ItemType Directory -Path $sshDir -Force }

# 2. 寫入公鑰 (請將下方的字串替換成您剛才複製的內容)
$myKey = "ssh-rsa AAAAB3Nza...您的公鑰內容...user@PC"
$myKey | Out-File -FilePath "$sshDir\administrators_authorized_keys" -Encoding ascii

# 3. 權限設定 (這是成功連線的關鍵)
icacls "$sshDir\administrators_authorized_keys" /inheritance:r
icacls "$sshDir\administrators_authorized_keys" /grant "Administrators:(R,W)"
icacls "$sshDir\administrators_authorized_keys" /grant "SYSTEM:(R,W)"

```

```Powershell
$path = "C:\ProgramData\ssh\administrators_authorized_keys"
icacls $path /inheritance:r
icacls $path /grant "Administrators:(R,W)"
icacls $path /grant "SYSTEM:(R,W)"

```

## Local client

### the ssh key

```Powershell
# Generate the key
# Enter file in which to save the key / Enter passphrase: Enter

ssh-keygen -t rsa -b 4096

# Get key
cat $env:USERPROFILE\.ssh\id_rsa.pub

```

### RustDesk

- local:　2222
- host: 127.0.0.1
- port: 22

### SOCKS5 tunel

```Powershell
ssh -p 2222 -D 1080 -o ServerAliveInterval=60 admin@127.0.0.1
```

## Proxy SwitchyOmega (ZeroOmega)

- 代理協議 SOCKS5
- 伺服器位址 127.0.0.1
- 連接埠 1080
