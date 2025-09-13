# 这是一个自动修改windows系统时间跳过xshell启动限制的ps脚本（xftp同理），使用前请修改脚本中的路径为实际的软件路径（实际脚本中以"xxxxxx"标注的部分）
# --------------------------------分界线--------------------------------

# [System.Console]::$OutputEncoding = [System.Console]::InputEncoding = [System.Text.Encoding]::UTF8

# ------- 第一步：判断是否以管理员权限运行 -------
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    # 重新以管理员身份启动 PowerShell 自己
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# ------- 第二步：实际任务开始（此处已是管理员权限） -------
# 保存当前系统时间
$originalTime = Get-Date

# 设置目标时间（你可以自定义）
$targetTime = Get-Date "2016-01-01 10:00:00"
Set-Date -Date $targetTime

# 启动目标软件（请修改为你实际的软件路径）
Start-Process "D:\xxxxxx\Xshell.exe"
# Start-Process "D:\xxxxxx\Xftp.exe"

# 稍微等待几秒以确保软件启动
Start-Sleep -Seconds 3

# 恢复原来的系统时间
## 注意主机系统W32Time服务是否已启动运行
# Set-Date -Date $originalTime
w32tm /resync
