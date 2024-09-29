//
//  ShopUsorApp.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI

@main
struct ShopUsorApp: App {
    
    @State var showOnboarding = false
    @State var showMainScreens = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack {
                    EntryScreen {
                        withAnimation {
                            
                            self.showOnboarding = true
                        }
                    }
                    
                    if showOnboarding {
                        OnboardingPage {
                            withAnimation {
                                showMainScreens = true
                            }
                        }
                    }
                    
                    if showMainScreens {
                        withAnimation {
                            MainView()
                        }
                    }
                }
            }
        }
    }
}

