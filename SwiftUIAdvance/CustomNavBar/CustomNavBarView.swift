//
//  CustomNavBarView.swift
//  SwiftUIAdvance
//
//  Created by loratech on 06/03/24.
//

import SwiftUI

struct CustomNavBarView: View {
    
    let showBackButton: Bool = true
    let title: String
    let subTitle: String?

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .foregroundStyle(.white)
        .font(.headline)
        .background(
            Color.blue.ignoresSafeArea(edges: .top)
        )
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if subTitle != nil {
                Text(subTitle!)
            }
        }
    }
}

#Preview {
    VStack{
        CustomNavBarView(title: "Title", subTitle: "Subtitle goes here.")
        Spacer()
    }
}
