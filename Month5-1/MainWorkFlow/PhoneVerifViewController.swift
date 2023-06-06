//
//  PhoneVerifViewController.swift
//  Month5-1
//
//  Created by Sonun on 6/6/23.
//

import UIKit

class PhoneVerifViewController: UIViewController {
    
    private lazy var titleLbl: UILabel = {
            let title = UILabel()
            title.text = "Phone Verification"
            title.font = .systemFont(ofSize: 24)
            title.textColor = .black
            
            return title
    }()
    
    private var phoneTextField: UITextField = {
        var phoneTF = UITextField()
        phoneTF.placeholder = "Enter your phone number"
        phoneTF.layer.cornerRadius = 6
        phoneTF.backgroundColor = .white
        phoneTF.layer.borderWidth = 1
        phoneTF.layer.borderColor = UIColor.systemBlue.cgColor

        return phoneTF
    }()
    
    private let sendButton: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Send", for: .normal)
        loginBtn.layer.backgroundColor = UIColor.tintColor.cgColor
        loginBtn.layer.cornerRadius = 18
        return loginBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubViews()
        sendButton.addTarget(
            self, action: #selector(sendTap),
            for: .touchUpInside
        )
    }
    
    func setUpSubViews() {
        view.backgroundColor = .systemGray5
        view.addSubview(phoneTextField)
        view.addSubview(sendButton)
        view.addSubview(titleLbl)
                
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).offset(24)
            make.centerX.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.right.left.equalToSuperview().inset(16)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField).offset(60)
            make.centerX.equalToSuperview()
            make.right.left.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func sendTap() {
        if let number = phoneTextField.text, number != "" {
            AuthorizationManager.shared.verificationPhoneNumber(phoneNumber: number) { [weak self] status in
                guard self != nil else { return }
                self?.pushToOtpVC()
            }
        }
    }
    
    private func pushToOtpVC(){
        let vc = OTPViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

