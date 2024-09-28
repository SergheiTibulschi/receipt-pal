//
//  ScanUrCheckApp.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 27.09.2024.
//

import SwiftUI

@main
struct ScanUrCheckApp: App {
    @State var showOnboarding = false
    @State var showTabBar = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                EntryScreen {
                    self.showOnboarding = true
                }
            }
        }
    }
}
