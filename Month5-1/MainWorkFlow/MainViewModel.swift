import Foundation

class MainViewModel {
    
    private let networkManager = NetworkManager()
    
    func fetchProduct() async throws -> Products {
        try await networkManager.fetchProduct()
    }
}
