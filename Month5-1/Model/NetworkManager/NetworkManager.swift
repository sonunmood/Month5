import Foundation
import UIKit

let session = URLSession.shared

struct NetworkManager {
    enum HTTPMethods: String {
        case GET, POST, PUT
    }
    
    func fetchProducts(completion: @escaping(Products) -> ()) {
        
        let request = URLRequest(url: Constants.urlPaths.productUrl)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let statusCode = response as! HTTPURLResponse
            
            do {
                let result = try JSONDecoder().decode(Products.self, from: data)
                print(result)
                completion(result)
                print(statusCode.statusCode)
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
