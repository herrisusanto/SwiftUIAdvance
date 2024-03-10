//
//  ProtocolBootcamp.swift
//  SwiftUIAdvance
//
//  Created by loratech on 08/03/24.
//

import SwiftUI

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct DefaultThemeColor: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeThemeColor: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
    func buttonPress()
}

class DefaultDataSource: ButtonTextProtocol {
    func buttonPress() {
        print("Default data source button pressed")
    }
    
    var buttonText: String = "Hi John Doe!"
}

class AlternativeDataSource: ButtonTextProtocol {
    func buttonPress() {
        print("Alternative data source button pressed")
    }
    
    var buttonText: String = "Hello, John Doe!"
}
struct ProtocolBootcamp: View {

    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonTextProtocol

    var body: some View {
        ZStack{
            colorTheme.primary
                .ignoresSafeArea()
            Text(dataSource.buttonText)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    dataSource.buttonPress()
                }

        }
    }
}

#Preview {
    ProtocolBootcamp(colorTheme: AlternativeThemeColor(), dataSource: AlternativeDataSource())
}
