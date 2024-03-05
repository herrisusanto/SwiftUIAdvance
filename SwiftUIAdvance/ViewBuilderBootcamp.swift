//
//  ViewBuilderBootcamp.swift
//  SwiftUIAdvance
//
//  Created by loratech on 05/03/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content:View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
             content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}



struct ViewBuilderBootcamp: View {
    var body: some View {
        HeaderViewRegular(title: "New Title", description: "Hello")
        HeaderViewGeneric(title: "Hi"){
            Text("John Doe")
        }
        HeaderViewGeneric(title: "Generic 3"){
            Text("Helloww")
            Image(systemName: "bolt.fill")
        }
        Spacer()
    }
    
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("View One!")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("View Two")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
    
    
}

#Preview {
    LocalViewBuilder(type: .three)
}
