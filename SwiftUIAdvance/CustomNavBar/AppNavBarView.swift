//
//  AppNavBarView.swift
//  SwiftUIAdvance
//
//  Created by loratech on 06/03/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(destination: Text("Destination")) {
                    Text("Navigate")
                }
                 
            }
        }
        .customNavigationTitle("Custom Title")
        .customNavigationSubtitle("Custom subtitle")
    }
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationStack{
            ZStack{
                Color.green.ignoresSafeArea()
                
                NavigationLink(
                    destination:
                        Text("Destination")
                        .navigationTitle("Title 2")
                        
                    
                ) {
                    Text("Navigate")
                }
            }
            .navigationTitle("Nav Title Here")
        }
    }
}

#Preview {
    AppNavBarView()
}
