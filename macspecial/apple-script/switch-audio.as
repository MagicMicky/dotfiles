ignoring application responses
	tell application "System Events" to tell process "SystemUIServer"
		click (menu bar item 1 of menu bar 1 where description starts with "volume")
		tell menu bar 1
			log (get description)
		end tell
	end tell
end ignoring


tell application "System Events" to tell process "SystemUIServer"
	
	tell (menu bar item 1 of menu bar 1 where description starts with "volume")
		log (get description)
		set device1 to menu item "FX-Audio-D-802" of menu 1
		set device2 to menu item "HyperX Cloud Flight S Chat" of menu 1
		
		if (value of attribute "AXMenuItemMarkChar" of device1) as string is "✓" then
			click device2
		else
			click device1
		end if
		
	end tell
end tell

