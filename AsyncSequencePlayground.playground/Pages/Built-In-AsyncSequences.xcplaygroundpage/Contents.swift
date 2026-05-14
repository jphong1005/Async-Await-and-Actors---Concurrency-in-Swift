//: [Previous](@previous)

import Foundation
import UIKit
import _Concurrency

let paths: [String] = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: nil)
let fileHandle: FileHandle? = FileHandle(forReadingAtPath: paths[0])

//  FileHandle
Task {
    for try await line in fileHandle!.bytes {
        print(line)
    }
}

//  URL
Task {
    let url: URL = URL(filePath: paths[0])
    
    for try await line in url.lines {
        print(line)
    }
}

//  URLSession
let url: URL = URL(string: "https://www.google.com")!

Task {
    let (bytes, _): (URLSession.AsyncBytes, URLResponse) = try await URLSession.shared.bytes(from: url)
    
    for try await byte in bytes {
        print(byte)
    }
}

//  Notifications
Task {
    let center: NotificationCenter = NotificationCenter.default
    let _ = await center.notifications(named: UIApplication.didEnterBackgroundNotification)
        .first { @Sendable notification in
            guard let key: String = (notification.userInfo?["Key"]) as? String else { return false }
            return key == "SomeValue"
        }
}

//: [Next](@next)
