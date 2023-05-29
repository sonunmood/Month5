import UIKit

class ProductTableViewCell: UITableViewCell {
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private let productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.tintColor = .blue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubViews() {
        selectionStyle = .none
        contentView.addSubview(productImageView)
        contentView.addSubview(productTitle)
        contentView.addSubview(productPrice)
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(200)
        }
        
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            make.left.equalTo(productImageView.snp.left)
            make.right.equalToSuperview().offset(-4)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(8)
            make.left.equalTo(productImageView.snp.left)
            make.right.equalTo(productImageView.snp.right)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func initCell(data: Product) {
        productImageView.getImage(from: data.thumbnail)
        productTitle.text = data.title
        productPrice.text = "\(data.price)"
    }
}
