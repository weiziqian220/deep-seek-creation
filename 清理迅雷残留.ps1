$ErrorActionPreference = 'SilentlyContinue'
$host.UI.RawUI.WindowTitle = '清理迅雷残留'
Write-Host '正在停止资源管理器（任务栏会闪一下，随后自动回来）...'
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 2
try {
  Remove-Item 'D:\迅雷' -Recurse -Force
  Write-Host '  D:\迅雷 已删除'
} catch { Write-Host '  D:\迅雷 删除失败:' $_.Exception.Message }
try {
  Remove-Item 'C:\ProgramData\Thunder Network' -Recurse -Force
  Write-Host '  ProgramData 缓存已删除'
} catch { Write-Host '  ProgramData 删除失败:' $_.Exception.Message }
foreach ($k in @('HKLM:\SOFTWARE\Thunder Network','HKLM:\SOFTWARE\WOW6432Node\Thunder Network')) {
  try { Remove-Item $k -Recurse -Force; Write-Host "  $k 已删除" } catch { Write-Host "  $k 删除失败" }
}
Start-Process explorer.exe
Write-Host ''
Write-Host '清理结束，按任意键关闭。'
[void]$Host.UI.RawUI.ReadKey()