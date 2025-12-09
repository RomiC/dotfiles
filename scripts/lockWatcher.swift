#!/usr/bin/env swift

import Foundation

class ScreenLockObserver {
    init() {
        let dnc = DistributedNotificationCenter.default()

        // listen for screen unlock
        let _ = dnc.addObserver(forName: NSNotification.Name("com.apple.screenIsUnlocked"), object: nil, queue: .main) { _ in
            NSLog("Screen Unlocked")
            self.runBashScript(path: "/Users/roman.charugin/work/raycast-extensions/scripts/wifi-toggle.sh")
        }

        RunLoop.main.run()
    }

    private func runBashScript(path: String) {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", path]
        task.launch()
        task.waitUntilExit()
    }
}

let _ = ScreenLockObserver()
