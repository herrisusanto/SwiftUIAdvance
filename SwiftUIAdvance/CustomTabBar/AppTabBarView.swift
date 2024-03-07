//
//  AppTabBarView.swift
//  SwiftUIAdvance
//
//  Created by loratech on 05/03/24.
//

// MARK:  We're using Generics, ViewBuilder, PreferenceKey and MatchedGeometryEffect

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection){
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
            Color.blue
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection){
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.green
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}



#Preview {
    AppTabBarView()
}
