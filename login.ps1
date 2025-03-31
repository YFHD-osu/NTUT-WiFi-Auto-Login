# Fill in your login credientials here
$USERNAME = ''
$PASSWORD = '';

# Customize the pop up message
$TARGET_SSID = "NTUT"
$NOTIFY_TITLE = "NTUT WiFi Auto Login"
$NOTIFY_FAILED_CONTEXT = "Failed to send the login request"
$NOTIFY_SUCCESS_CONTEXT = "Request has been sent successfully"

# Check for specific WiFi network
$CurrentSSID = (Get-NetConnectionProfile).Name
if ($null -eq $CurrentSSID) {
  Exit
}

$CurrentSSID = $CurrentSSID.split("\n")
if ($CurrentSSID -notcontains $TARGET_SSID) {
  Write-Host "Currently connected to" $CurrentSSID "but not" $TARGET_SSID ", skipping login process"
  Exit
}

Add-Type -AssemblyName System.Windows.Forms
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path

$postParams = @{username = $USERNAME ;password = $PASSWORD ;client_login='';rr=''}
try {
  Invoke-WebRequest -Uri "https://captiveportal-login.ntut.edu.tw/auth/index.html/u" -Method POST -Body $postParams -MaximumRedirection 0
  $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
  $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
  $balmsg.BalloonTipTitle = $NOTIFY_TITLE
  $balmsg.BalloonTipText = $NOTIFY_SUCCESS_CONTEXT
} catch {
  if ($_.Exception.Response.StatusCode.Value__ -eq 302) {
    Exit # Wifi is already logged-in, skip the error notification
  }
  $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
  $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error
  $balmsg.BalloonTipTitle = $NOTIFY_TITLE 
  $balmsg.BalloonTipText = $NOTIFY_FAILED_CONTEXT
  Write-Host "Failed to login, code:" $_.Exception.Response.StatusCode.Value__
}

$balmsg.Visible = $true
$balmsg.ShowBalloonTip(200)