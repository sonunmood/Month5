import UIKit

enum Constants {
    enum urlPaths {
    static let productUrl = URL(
        string: "https://dummyjson.com/products")!
    }
    
    enum reuseId {
        static let collectionViewId = "CategoryCollectionViewCell"
        static let subCollectionViewId = "SubCategoriesCollectionViewCell"
        static let tableViewId = "ProductTableViewCell"
    }
    
    enum keyChain {
        static let service = "Instagram"
        static let account = "Login"
    }
}
