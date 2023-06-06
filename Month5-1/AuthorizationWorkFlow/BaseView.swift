//
//  UIView.swift
//  Month5-1
//
//  Created by Sonun on 5/6/23.
//

import UIKit

protocol BaseViewDelegate: AnyObject {
    func didTapPhone()
    func didTapGoogle()
}

class BaseView: UIStackView {
    
    private let googleImageView: UIImageView = {
        let google = UIImageView()
        google.image = UIImage(named: "google")
        
        google.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        return google
    }()
    
    private let phoneBtn: UIImageView = {
        let phone = UIImageView()
        phone.image = UIImage(named: "phone")
        phone.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        return phone
    }()
    
    private let instagramImageView: UIImageView = {
        let instagram = UIImageView()
        instagram.image = UIImage(named: "instagram")
        instagram.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        return instagram
    }()
    
    weak var delegate: BaseViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        axis = .horizontal
        distribution = .equalCentering
        addArrangedSubview(phoneBtn)
        addArrangedSubview(instagramImageView)
        addArrangedSubview(googleImageView)
        
        googleImageView.isUserInteractionEnabled = true
        googleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGoogleBtn)))
        
        phoneBtn.isUserInteractionEnabled = true
        phoneBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPhoneBtn)))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapGoogleBtn(){
        delegate?.didTapGoogle()
    }
    
    @objc private func didTapPhoneBtn(){
        delegate?.didTapPhone()
    }
}

