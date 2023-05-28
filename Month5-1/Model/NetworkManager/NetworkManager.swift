import Foundation
import UIKit

let session = URLSession.shared

struct NetworkManager {
    enum HTTPMethods: String {
        case GET, POST, PUT
    }
    
    func fetchProduct() async throws -> Products {
        let request = URLRequest(url: Constants.urlPaths.productUrl)
        let (data, _) = try await session.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
