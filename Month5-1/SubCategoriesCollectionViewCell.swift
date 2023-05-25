//
//  SubCategoriesCollectionViewCell.swift
//  Month5-1
//
//  Created by Sonun on 16/5/23.
//

import UIKit

class SubCategoriesCollectionViewCell: UICollectionViewCell {
    
    private let subCategoryImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    private let imageTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 12)
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        contentView.addSubview(subCategoryImage)
        contentView.addSubview(imageTitle)
        
        subCategoryImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        imageTitle.snp.makeConstraints { make in
            make.top.equalTo(subCategoryImage.snp.bottom).offset(10)
            make.centerX.equalTo(subCategoryImage.snp.centerX)
            make.right.left.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func initCell(model: SubCategories) {
        subCategoryImage.image = UIImage(named: model.subcategoriesImage)
        imageTitle.text = model.subCategoriesTitle
    }
}
