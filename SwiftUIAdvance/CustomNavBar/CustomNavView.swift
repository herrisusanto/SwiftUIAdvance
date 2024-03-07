//
//  CustomNavView.swift
//  SwiftUIAdvance
//
//  Created by loratech on 06/03/24.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack{
            CustomNavBarContainerView {
                content
            }
        }
        
    }
}

#Preview {
    CustomNavView {
        Color.red.ignoresSafeArea()
    }
}
