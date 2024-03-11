//
//  UnitTestingBootcampView.swift
//  SwiftUIAdvance
//
//  Created by loratech on 10/03/24.
//

/*
1. Unit Tests
- Test business logic in app

2. UI Tests
- Test the UI of the app
 */

import SwiftUI



struct UnitTestingBootcampView: View {
    @StateObject private var viewModel: UnitTestingBootcampViewModel

    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: true)
}
