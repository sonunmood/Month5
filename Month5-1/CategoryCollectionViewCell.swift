//
//  CategoryCollectionViewCell.swift
//  Month5-1
//
//  Created by Sonun on 11/5/23.
//
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let backview = UIView()
        backview.layer.borderWidth = 1
        backview.layer.cornerRadius = 18
        backview.layer.borderColor = UIColor.systemGray.cgColor
        return backview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    func initData(model: Categories) {
        titleLabel.text = model.categoriesTitle
    }
}

