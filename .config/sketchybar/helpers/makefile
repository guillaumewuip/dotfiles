all:
	(cd event_providers && $(MAKE)) >/dev/null
	swiftc calendar_event.swift -o calendar_event
	swiftc -O network_load.swift -o network_load
