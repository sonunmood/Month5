import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    var categories: [Categories] = [.init(categoriesTitle: "Delivery"),
                                    .init(categoriesTitle: "Pick up"),
                                    .init(categoriesTitle: "Catering"),
                                    .init(categoriesTitle: "Carbside"),
                                    .init(categoriesTitle: "Technics"),
                                    .init(categoriesTitle: "Parfumes")]
    var subCategories: [SubCategories] = [.init(subcategoriesImage: "takeaways",
                                                subCategoriesTitle: "Takeaways"),
                                          .init(subcategoriesImage: "grocery",
                                                subCategoriesTitle: "Grocery"),
                                          .init(subcategoriesImage: "pharmacy",
                                                subCategoriesTitle: "Pharmacy"),
                                          .init(subcategoriesImage: "convenience",
                                                subCategoriesTitle: "Convenience"),
                                          .init(subcategoriesImage: "takeaways",
                                                subCategoriesTitle: "Takeaways")]
    var products: [Product] = []
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.estimatedItemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseId.collectionViewId)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searсhBar = UISearchBar()
        searсhBar.placeholder = "Find store by name"
        searсhBar.backgroundColor = .clear
        return searсhBar
    }()
    
    private lazy var subcategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 88.0, height: 110.0)
        
        let collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView2.register(SubCategoriesCollectionViewCell.self,
                                 forCellWithReuseIdentifier: Constants.reuseId.subCollectionViewId)
        collectionView2.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                    bottom: 0, right: 0)
        collectionView2.showsHorizontalScrollIndicator = false
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.backgroundColor = .white
        return collectionView2
    }()
    
    private lazy var productTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .white
        tv.register(ProductTableViewCell.self,
                    forCellReuseIdentifier: Constants.reuseId.tableViewId)
        
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        fetchProducts()
    }
    
    func fetchProducts() -> () {
        
        Task {
            do {
                let response = try await networkManager.fetchProduct()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productTableView.reloadData()
                }
            } catch {
                showAlert(with: error)
            }
        }
    }
    
    func showAlert(with massage: Error) {
        let alert = UIAlertController(title: "OK", message: massage.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    func setupSubviews() {
        view.addSubview(categoryCollectionView)
        view.addSubview(searchBar)
        view.addSubview(subcategoryCollectionView)
        view.addSubview(productTableView)
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        subcategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview()
            make.height.equalTo(110)
        }
        
        productTableView.snp.makeConstraints { make in
            make.top.equalTo(subcategoryCollectionView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}

extension MainViewController: UICollectionViewDataSource,
                              UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == categoryCollectionView {
            count = categories.count
        } else if collectionView == subcategoryCollectionView {
            count = subCategories.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if collectionView == categoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseId.collectionViewId,for: indexPath) as! CategoryCollectionViewCell
            categoryCell.initData(model: categories[indexPath.row])
            cell = categoryCell
        } else if collectionView == subcategoryCollectionView {
            let subcategotyCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseId.subCollectionViewId,for: indexPath) as! SubCategoriesCollectionViewCell
            subcategotyCell.initCell(model: subCategories[indexPath.row])
            cell = subcategotyCell
        }
        return cell
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseId.tableViewId, for: indexPath) as! ProductTableViewCell
        cell.initCell(data: products[indexPath.row])
        return cell
    }
}

