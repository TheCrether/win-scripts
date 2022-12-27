$hour = [int](Get-Date -Format "HH")
$newVal = 0
if ($hour -ge 7 -and $hour -le 16) {
	# set light theme between 7am and 4pm
	$newVal = 1
}
else {
	# set dark theme between 4pm and 7am
	$newVal = 0
}

# set the theme if it's different
$PATH = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$current = Get-ItemProperty -Path "$PATH" -Name AppsUseLightTheme
if ($current.AppsUseLightTheme -ne $newVal) {
	Set-ItemProperty -Path "$PATH" -Name AppsUseLightTheme -Value $newVal
}