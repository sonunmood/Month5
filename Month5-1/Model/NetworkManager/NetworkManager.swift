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
    
//    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void
//    ) {
//        var request = URLRequest(url: Constants.urlPaths.productUrl)
//        request.httpMethod = HTTPMethods.GET.rawValue
//        session.dataTask(with: request)
//        { data, response, error in
//            if let error {
//                completion(.failure(error))
//            }
//            guard let data else {
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let data = try decoder.decode(
//                    Products.self,
//                    from: data)
//                completion(
//                    .success(
//                        data.products))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        .resume()
//    }
}
