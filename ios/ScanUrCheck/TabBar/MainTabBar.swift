//
//  MainTabBar.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI
import NoughtyUI

enum Tab {
    case main
    case graphics
    case settings
    case search
}

struct MainTabBar: View {
    @State var selectedTab: Tab = .main
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            MainView()
                .tag(Tab.main)
                .tabItem {
                    Text("Main")
                        .foregroundStyle(.black)
                    
                    Image(systemName: "list.clipboard")
                        .foregroundStyle(.black)
                }
            
            PieChartExampleView()
                .tag(Tab.graphics)
                .tabItem {
                   // VStack {
                        Text("Graphics")
                            .foregroundStyle(.black)
                        
                        Image(systemName: "cellularbars")
                        .foregroundStyle(.black)
                  //  }
                  //  .background(.white)
                }
            
//            Rectangle().fill(Color.ultraViolet)
//                .tag(Tab.search)
//                .tabItem {
//                    Text("Search")
//                        .foregroundStyle(.black)
//                    
//                    Image(systemName: "magnifyingglass.circle")
//                        .foregroundStyle(.black)
//                }
            
            Rectangle().fill(Color.teaRose)
                .tag(Tab.settings)
                .tabItem {
                    Text("Settings")
                        .foregroundStyle(.black)
                    
                    Image(systemName: "gearshape")
                        .foregroundStyle(.black)
                }
        }
        .tint(Color.teaRose)
        .background(Color.ultraViolet)
        .onAppear(perform: {
            UITabBar.appearance().backgroundColor = .init(Color.ultraViolet)
            UITabBar.appearance().barTintColor = .init(Color.ultraViolet)
        })
    }
}

#Preview {
    MainTabBar()
}
