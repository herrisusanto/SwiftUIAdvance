//
//  DependencyInjectionBootcamp.swift
//  SwiftUIAdvance
//
//  Created by loratech on 10/03/24.
//

import SwiftUI
import Combine

// MARK:  Singleton's problems
// 1. Singleton's are GLOBAL
// 2. Can't customize the init
// 3. Can't swap out dependecies

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[Post], Error>
}

class ProductionDataService {
    // MARK:  Singleton
    // static let shared = ProductionDataService()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func getData() -> AnyPublisher<[Post], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data})
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData: [Post]

    init(testData: [Post]?) {
        self.testData = testData ?? [
            .init(userId: 1, id: 1, title: "One", body: "one"),
            .init(userId: 2, id: 2, title: "Two", body: "Two"),
            .init(userId: 3, id: 3, title: "Three", body: "Three")
        ]
    }

    func getData() -> AnyPublisher<[Post], any Error> {
        Just(testData)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    
}


class DependencyInjectionViewModel: ObservableObject {

    @Published var posts: [Post] = []
    var cancellables = Set<AnyCancellable>()
    let service: DataServiceProtocol

    init(service: DataServiceProtocol) {
        self.service = service
        loadPosts()
    }

    private func loadPosts() {
        service.getData()
            .sink { _ in

            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)

    }
}

struct DependencyInjectionBootcamp: View {
    @StateObject private var viewModel: DependencyInjectionViewModel

    init(service: DataServiceProtocol) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(service: service))
    }
    var body: some View {
        ScrollView{
            VStack {
                ForEach(viewModel.posts) { post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {
let service = MockDataService(testData: nil)
   return DependencyInjectionBootcamp(service: service)
}
