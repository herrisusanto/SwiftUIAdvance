//
//  UIViewRepresentableBootcamp.swift
//  SwiftUIAdvance
//
//  Created by loratech on 07/03/24.
//

import SwiftUI

struct UIViewRepresentableBootcamp: View {
    @State private var text: String = ""
    var body: some View {
        Text(text)
        HStack{
            Text("Swift UI")
            TextField("Type here...", text: $text)
                .frame(height: 55)
                .background(Color.blue)
        }

        HStack{
            Text("UIKit")
            UITextFieldRepresentable(text: $text, placeholderColor: UIColor.cyan)
                .updatePlaceholder("New placeholder")
                .frame(height: 55)
                .background(Color.gray)
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldRepresentable: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor

    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }

    func makeUIView(context: Context) -> UITextField {
        let textfield = getTextField()
        textfield.delegate = context.coordinator
        return textfield
    }
    // MARK:  Send data from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    // MARK:  Send data from UIKit to SwiftUI
    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String

        init(text: Binding<String>){
            self._text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }

    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : placeholderColor])
        textfield.attributedPlaceholder = placeholder
        return textfield
    }

    func updatePlaceholder(_ text: String) -> UITextFieldRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text

        return viewRepresentable
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = UIColor.systemPink
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
