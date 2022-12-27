# code from https://www.reddit.com/r/PowerShell/comments/hkbhha/how_to_check_if_a_process_is_running_elevated/
function Test-IsAdmin {
	$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# check if the current process is already elevated
if (Test-IsAdmin) {
	# process is elevated, start taskmgr
	$procExpPath = "D:\Program Files\Sysinternals\ProcessExplorer\procexp.exe"
	if ($args[0] -and (Test-Path $args[0])) {
		$procExpPath = $args[0]
	}
	reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v Debugger /f
	Start-Process taskmgr.exe
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v Debugger /t REG_SZ /d "${procExpPath}" /f
}
else {
	# try to start a new elevated process
	if ($args[0]) {
		Start-Process powershell -verb runas -ArgumentList ($MyInvocation.MyCommand.Path, $args[0])
	}
	else {
		Start-Process powershell -verb runas -ArgumentList ($MyInvocation.MyCommand.Path)
	}
}