$date = Get-Date -Format "HH:mm"
$time = $date.Split(":")
$hour = [int]$time[0]

$PATH = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"

$current = Get-ItemProperty -Path "$Path" -Name AppsUseLightTheme
$newVal = 0

if ($hour -ge 7 -and $hour -le 16) {
	$newVal = 1
}
else {
	$newVal = 0
}

if ($current.AppsUseLightTheme -ne $newVal) {
	Set-ItemProperty -Path "$Path" -Name AppsUseLightTheme -Value $newVal
}