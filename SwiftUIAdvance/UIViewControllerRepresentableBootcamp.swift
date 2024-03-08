//
//  UIViewControllerRepresentableBootcamp.swift
//  SwiftUIAdvance
//
//  Created by loratech on 08/03/24.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    @State private var showScreen: Bool = false
    @State private var image: UIImage? = nil
    var body: some View {
        VStack{
            Text("Hi")
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Button(action: {
                showScreen.toggle()
            },label: {
                Text("Click Me")
            })
            .sheet(isPresented: $showScreen, content: {
                UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
            })
        }
    }
}

#Preview {
    UIViewControllerRepresentableBootcamp()
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {

    @Binding var image: UIImage?
    @Binding var showScreen: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }

    // MARK:  Send data from SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    // MARK:  Send data from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool

        init(image: Binding<UIImage?>, showScreen: Binding<Bool> ) {
            self._image = image
            self._showScreen = showScreen
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showScreen = false
        }
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let labelText: String
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = FirstViewController()
        vc.labelText = labelText
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

class FirstViewController: UIViewController {
    var labelText: String = "Hell world!"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        view.addSubview(label)
        label.frame = view.frame

    }
}
