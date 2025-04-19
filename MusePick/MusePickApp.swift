//
//  MusePickApp.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import SwiftUI
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

@main
struct MusePickApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FirstContentView()
        }
    }
}
