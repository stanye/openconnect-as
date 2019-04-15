#!/usr/bin/osascript
on run args
	set titleStr to "?????"
	set btns to {"ok", "cancel"}
	set returnRecord to display dialog titleStr default answer "" buttons btns default button 1
	set theTextInput to text returned of returnRecord
	set theButtonPressed to button returned of returnRecord
	
	set vpnPWD to "{vpnPWD}"
	set TrueVpnPWD to theTextInput & vpnPWD
	
	set vpnGroup to "SSLVPNClient"
	set vpnUname to "{vpnUname}"
	set suffixUsername to " -u " & vpnUname
	
	set adminPWD to "{adminPWD}"
	
	set servercert to "{sha256:servercert}"
	set suffixServercert to " --servercert " & servercert
	
	set vpnAddress to "{vpnAddress}"
	
	set sshCommand to "sudo openconnect " & vpnAddress & suffixUsername & suffixServercert & " -b"
	
	if theButtonPressed is "ok" then
		tell application "Terminal"
			if not (exists window 1) then reopen
			if (count of windows) is not 0 then
				do script sshCommand in window 1
			else
				do script sshCommand
			end if
			activate
			
			delay 1
			set the clipboard to adminPWD
			tell application "System Events"
				key code 9 using command down
				key code 76
			end tell
			
			delay 1
			set the clipboard to vpnGroup
			tell application "System Events"
				key code 9 using command down
				key code 76
			end tell
			
			delay 1
			set the clipboard to TrueVpnPWD
			tell application "System Events"
				key code 9 using command down
				key code 76
			end tell
			
			delay 5
			tell application "System Events"
				tell process "Terminal"
					keystroke "w" using {command down}
				end tell
			end tell
			
		end tell
	end if
end run




