#!/usr/bin/env swift
import Darwin
import Foundation
import Network

// MARK: - Byte counter reading

struct IfStats {
    var ibytes: UInt32
    var obytes: UInt32
}

func readStats(for ifname: String) -> IfStats? {
    var ifap: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifap) == 0 else { return nil }
    defer { freeifaddrs(ifap) }

    var cur = ifap
    while let p = cur {
        let name = String(cString: p.pointee.ifa_name)
        if name == ifname, p.pointee.ifa_addr?.pointee.sa_family == UInt8(AF_LINK) {
            var stats = IfStats(ibytes: 0, obytes: 0)
            p.pointee.ifa_data?.withMemoryRebound(to: if_data.self, capacity: 1) { data in
                stats = IfStats(ibytes: data.pointee.ifi_ibytes, obytes: data.pointee.ifi_obytes)
            }
            return stats
        }
        cur = p.pointee.ifa_next
    }
    return nil
}

// MARK: - Rate formatting (mirrors C binary: "%03d%s")

enum Unit: Int { case bps = 0, kbps = 1, mbps = 2 }
let unitStr = [" Bps", "KBps", "MBps"]

func formatRate(_ bytesPerSec: Double) -> String {
    let exp = bytesPerSec > 0 ? log10(bytesPerSec) : 0
    let (value, unit): (Int, Unit)
    if exp < 3 {
        (value, unit) = (Int(bytesPerSec), .bps)
    } else if exp < 6 {
        (value, unit) = (Int(bytesPerSec / 1_000), .kbps)
    } else {
        (value, unit) = (Int(bytesPerSec / 1_000_000), .mbps)
    }
    return String(format: "%03d%@", value, unitStr[unit.rawValue])
}

// MARK: - Sketchybar trigger

func trigger(upload: String, download: String) {
    let msg = "--trigger network_update upload='\(upload)' download='\(download)'"
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/sketchybar")
    task.arguments = ["--trigger", "network_update", "upload=\(upload)", "download=\(download)"]
    try? task.run()
    task.waitUntilExit()
    _ = msg  // suppress unused warning
}

// MARK: - Main loop

let updateInterval: Double = 2.0

var currentInterface: String? = nil
var prevStats: IfStats? = nil
var prevTime: Date? = nil

let monitor = NWPathMonitor()
let monitorQueue = DispatchQueue(label: "net.monitor")

monitor.pathUpdateHandler = { path in
    // Pick the first real interface on the default path
    let preferred = path.availableInterfaces.first { iface in
        iface.type == .wiredEthernet || iface.type == .wifi || iface.type == .cellular
    } ?? path.availableInterfaces.first

    let newIface = preferred?.name
    if newIface != currentInterface {
        currentInterface = newIface
        // Reset counters so the first tick after a switch doesn't produce a spike
        prevStats = nil
        prevTime = nil
    }
}
monitor.start(queue: monitorQueue)

// Give NWPathMonitor a moment to fire its initial update
Thread.sleep(forTimeInterval: 0.2)

// Main polling loop
while true {
    let now = Date()

    if let iface = currentInterface, let stats = readStats(for: iface) {
        if let prev = prevStats, let pt = prevTime {
            let dt = now.timeIntervalSince(pt)
            if dt > 0.01 {
                let upRate = Double(stats.obytes >= prev.obytes ? stats.obytes - prev.obytes : 0) / dt
                let downRate = Double(stats.ibytes >= prev.ibytes ? stats.ibytes - prev.ibytes : 0) / dt
                trigger(upload: formatRate(upRate), download: formatRate(downRate))
            }
        }
        prevStats = stats
        prevTime = now
    } else {
        // No interface or can't read stats — show zeros
        trigger(upload: "000 Bps", download: "000 Bps")
        prevStats = nil
        prevTime = nil
    }

    Thread.sleep(forTimeInterval: updateInterval)
}
