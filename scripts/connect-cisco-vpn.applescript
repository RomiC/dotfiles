property startupTimeout : 30

on run
	set clientID to missing value
	set clientApp to missing value
	repeat with candidateID in {"com.cisco.secureclient.gui", "com.cisco.anyconnect.gui"}
		try
			set clientApp to path to application id (contents of candidateID)
			set clientID to contents of candidateID
			exit repeat
		end try
	end repeat
	if clientApp is missing value then error "Cisco Secure Client (or AnyConnect) could not be found. Install it before running this script."

	tell application "System Events"
		if not UI elements enabled then error "Enable Accessibility access for the app running this script in System Settings → Privacy & Security → Accessibility, then try again."
	end tell

	do shell script "/usr/bin/open " & quoted form of POSIX path of clientApp
	set deadline to (current date) + startupTimeout
	repeat while (current date) < deadline
		tell application "System Events"
			set clients to application processes whose bundle identifier is clientID
			if (count of clients) > 0 then
				set clientProcess to item 1 of clients
				set frontmost of clientProcess to true
				set clientWindows to windows of clientProcess
			else
				set clientWindows to {}
			end if
		end tell

		repeat with clientWindow in clientWindows
			set disconnectButton to my findButton(clientWindow, "Disconnect")
			if disconnectButton is not missing value then return "VPN is already connected or connecting; no action taken."
		end repeat

		repeat with clientWindow in clientWindows
			set connectButton to my findButton(clientWindow, "Connect")
			if connectButton is not missing value then
				tell application "System Events"
					if enabled of connectButton then
						click connectButton
						return "VPN connection requested. Complete any login or MFA prompts in Cisco Secure Client."
					end if
				end tell
			end if
		end repeat
		delay 0.5
	end repeat

	error "Could not find an enabled Connect button. Select your VPN server in Cisco Secure Client and try again. This script expects English Connect/Disconnect button labels."
end run

on findButton(containerElement, buttonName)
	tell application "System Events"
		-- VPN controls can be nested inside groups rather than directly in the window.
		set descendants to entire contents of containerElement
		repeat with candidate in descendants
			if class of candidate is button then
				if name of candidate is buttonName then return contents of candidate
			end if
		end repeat
	end tell
	return missing value
end findButton
