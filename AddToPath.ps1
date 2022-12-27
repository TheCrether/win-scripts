Param (
	[Parameter(Position = 0, Mandatory = $false)]
	[string]$Path = "${PSScriptRoot}",

	[Parameter(Position = 1, Mandatory = $false)]
	[ValidateSet("User", "Machine")]
	[string]$Target = "User"
)

# checks if the current process is elevated
function Test-IsAdmin {
	$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function AddPath {
	Param (
		[Parameter(Position = 0, Mandatory = $true)]
		[string]$Path,

		[Parameter(Position = 1, Mandatory = $true)]
		[ValidateSet("User", "Machine")]
		[string]$Target
	)

	$curPath = [Environment]::GetEnvironmentVariable("PATH", $Target)
	# check if the path is already included
	if ($curPath -like "*${Path}*") {
		Write-Host "Path already included in ${Target}:PATH environment variable"
		Read-Host "Press any key to continue..."
		return
	}

	# add the path to the environment variable and set it
	$newPath = $curPath + [IO.Path]::PathSeparator + $Path
	[Environment]::SetEnvironmentVariable("PATH", $newPath, $Target)
}

if ($args[0] -and $args[0] -eq "Machine") {
	$Target = "Machine"
}

if (Test-IsAdmin) {
	# process is elevated, add path, doesn't matter which target
	AddPath -Path "${Path}" -Target $Target
}
elseif ($Target -eq "Machine" -and -not (Test-IsAdmin -Process (Get-Process -Id $PID))) {
	# try to start a new elevated process
	Write-host "Starting a new elevated process to add path to ${Target}:PATH environment variable"
	Start-Process powershell -verb runas -ArgumentList ($MyInvocation.MyCommand.Path, $Path, $Target)
}
else {
	AddPath -Path "${Path}" -Target $Target
}
