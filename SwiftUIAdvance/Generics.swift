//
//  Generics.swift
//  SwiftUIAdvance
//
//  Created by loratech on 05/03/24.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
        
    @Published var genericStringModel = GenericModel(info: "Hello, world!")
    @Published var genericBoolModel = GenericModel(info: true)
     
    
    func removeData() {
        genericBoolModel =  genericBoolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
    }
}

struct GenericView<T:View>: View {
    let content: T
    let title: String
    var body: some View {
        Text(title)
        content
    }
}

struct Generics: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack{
            GenericView(content: Text("Generic view is here."), title: "Button")
            Text(vm.genericStringModel.info ?? "No data")
            Text(vm.genericBoolModel.info?.description ?? "No data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    Generics()
}
