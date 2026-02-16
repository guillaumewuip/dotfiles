#!/usr/bin/env swift
import EventKit
import Foundation

let store = EKEventStore()
let semaphore = DispatchSemaphore(value: 0)

if #available(macOS 14.0, *) {
    store.requestFullAccessToEvents { granted, error in
        defer { semaphore.signal() }
        findNextEvent(granted: granted)
    }
} else {
    store.requestAccess(to: .event) { granted, error in
        defer { semaphore.signal() }
        findNextEvent(granted: granted)
    }
}

func findNextEvent(granted: Bool) {
    guard granted else {
        print("NO_EVENT")
        return
    }
    
    let now = Date()
    let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: now))!
    
    let predicate = store.predicateForEvents(withStart: now, end: endOfDay, calendars: nil)
    let events = store.events(matching: predicate)
    
    // Find first event that hasn't ended yet
    for event in events.sorted(by: { $0.startDate < $1.startDate }) {
        if event.endDate >= now {
            let title = event.title ?? "Untitled"
            let startTs = Int(event.startDate.timeIntervalSince1970)
            let endTs = Int(event.endDate.timeIntervalSince1970)
            print("\(title)|\(startTs)|\(endTs)")
            return
        }
    }
    
    print("NO_EVENT")
}

semaphore.wait()
