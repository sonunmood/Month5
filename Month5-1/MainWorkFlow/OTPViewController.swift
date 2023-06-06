//
//  OTPViewController.swift
//  Month5-1
//
//  Created by Sonun on 6/6/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    private var otpTextField: UITextField = {
        var otpTF = UITextField()
        otpTF.placeholder = "Enter the code"
        otpTF.layer.cornerRadius = 6
        otpTF.backgroundColor = .white
        otpTF.layer.borderWidth = 1
        otpTF.layer.borderColor = UIColor.systemBlue.cgColor
        return otpTF
    }()
    
    private let confirmButton: UIButton = {
        let confirmBtn = UIButton()
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.layer.backgroundColor = UIColor.tintColor.cgColor
        confirmBtn.layer.cornerRadius = 18
        return confirmBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubViews()
    }
    
    func setUpSubViews() {
        
        view.backgroundColor = .systemGray5
        view.addSubview(otpTextField)
        view.addSubview(confirmButton)
        
        otpTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            make.right.left.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(otpTextField).offset(60)
            make.centerX.equalToSuperview()
            make.right.left.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        confirmButton.addTarget(self,
                                action: #selector(didTapConfirmBtn),
                                for: .touchUpInside)
    }
    
    @objc
    private func didTapConfirmBtn(){
        if let code = otpTextField.text, code != "" {
            AuthorizationManager.shared.tryToLogin(smsCode: code) { [weak self] success in
                guard self != nil else { return }
                self?.pushToMainVC()
            }
        }
    }
    
    private func pushToMainVC(){
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
