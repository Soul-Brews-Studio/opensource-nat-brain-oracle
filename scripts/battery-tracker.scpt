-- Battery Tracker AppleScript
-- Shows notification with battery status

on run
	set batteryInfo to do shell script "pmset -g batt"
	set batteryPercent to do shell script "echo " & quoted form of batteryInfo & " | grep -o '[0-9]*%' | head -1"

	if batteryInfo contains "charging" then
		set statusIcon to "⚡"
		set statusText to "Charging"
	else if batteryInfo contains "AC Power" then
		set statusIcon to "🔌"
		set statusText to "On Power"
	else
		set statusIcon to "🔋"
		set statusText to "On Battery"
	end if

	display notification statusIcon & " " & batteryPercent & " - " & statusText with title "Battery Status"

	return batteryPercent & " " & statusText
end run
