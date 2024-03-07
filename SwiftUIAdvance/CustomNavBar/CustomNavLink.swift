//
//  CustomNavLink.swift
//  SwiftUIAdvance
//
//  Created by loratech on 06/03/24.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                destination
            }).navigationBarBackButtonHidden(),
            label: {
                label
            })
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(
            destination: Text("Destination")) {
                Text("Click Me!")
            }
    }
}
