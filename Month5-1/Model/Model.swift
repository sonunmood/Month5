import Foundation

struct Categories {
    let categoriesTitle: String
}

struct SubCategories {
    let subcategoriesImage: String
    let subCategoriesTitle: String
}

struct Products: Decodable {
    var products: [Product]
}

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let category: String
    let thumbnail: String
}
