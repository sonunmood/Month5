import UIKit
import GoogleSignIn

class AuthorizationViewController: UIViewController {

    private let headerImage: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "headerImage")
        return mainImage
    }()
    
    private let welcomLabel: UILabel  = {
        let welcomeLbl = UILabel()
        welcomeLbl.text = "Welcome"
        welcomeLbl.textColor = .white
        welcomeLbl.font = .boldSystemFont(ofSize: 28)
        return welcomeLbl
    }()

    private var loginTextField: UITextField = {
        var loginTF = UITextField()
        loginTF.placeholder = "Login"
        loginTF.layer.cornerRadius = 6
        loginTF.backgroundColor = .white
        loginTF.layer.borderWidth = 1
        return loginTF
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.placeholder = "Password"
        passwordTF.backgroundColor = . white
        passwordTF.layer.cornerRadius = 6
        passwordTF.layer.borderWidth = 1
        passwordTF.isSecureTextEntry = false
        return passwordTF
    }()
    
    private let eyeButton: UIButton = {
        let eyeBtn = UIButton()
        eyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        return eyeBtn
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Not Saved", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.tintColor = .white
        return button
    }()
    
    private let loginButton: UIButton = {
        let loginBtn = UIButton()
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.layer.backgroundColor = UIColor.tintColor.cgColor
        loginBtn.layer.cornerRadius = 18
        return loginBtn
    }()
    
    private let accountLabel: UILabel = {
        let accountLbl = UILabel()
        accountLbl.text = "Sign in with:"
        accountLbl.textColor = .gray
        accountLbl.font = .systemFont(ofSize: 16)
        return accountLbl
    }()
    
    private lazy var iconImages: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()
    
    private var isSave = false {
        didSet {
            let isSavedTitle = isSave ? "Saved" : "Save"
            saveButton.setTitle(isSavedTitle, for: .normal)
            UserDefault.shared.save(isSave, forkey: .saveLogin)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initAction()
        handleLoginField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func handleLoginField() {
        isSave = UserDefault.shared.getBool(forkey: .saveLogin)
        let isLoginSaved = UserDefault.shared.getBool(forkey: .saveLogin)
        if isLoginSaved,
           let data = KeyChainManager.shared.read(with: Constants.keyChain.service, Constants.keyChain.account
           ),
           let data = String(data: data, encoding: .utf8) {
            loginTextField.text = data
        }
    }
    
    func initUI() {
        view.addSubview(headerImage)
        view.addSubview(welcomLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(saveButton)
        view.addSubview(loginButton)
        view.addSubview(accountLabel)
        view.addSubview(eyeButton)
        view.addSubview(iconImages)
        
        headerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        welcomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerImage.snp.bottom).offset(80)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.top.equalTo(welcomLabel.snp.bottom).offset(32)
            make.height.equalTo(48)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(28)
            make.top.equalTo(loginTextField.snp.bottom).offset(32)
            make.height.equalTo(48)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-4)
            make.centerY.equalTo(passwordTextField)
            make.width.equalTo(28)
            make.height.equalTo(24)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.height.equalTo(24)
            make.width.equalTo(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(saveButton.snp.bottom).offset(8)
            make.height.equalTo(48)
            make.width.equalTo(280)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(32)
        }
        
        iconImages.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(accountLabel.snp.bottom).offset(32)
            make.height.equalTo(40)
            make.width.equalTo(184)
        }
    }
    
    private func initAction() {
        
        loginButton.addTarget(self, action: #selector(authorizeTap), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(tapEyeButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveLoginTap), for: .touchUpInside)
    }

    @objc
    private func authorizeTap(sender: UIButton) {
        guard
            let login = loginTextField.text,
            !login.isEmpty,
            !(passwordTextField.text?.isEmpty ?? true) else {
            return
        }
        let data = Data(login.utf8)
        KeyChainManager.shared.save(
            data,
            service: Constants.keyChain.service,
            account: Constants.keyChain.account
        )
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func tapEyeButton(sender: UIButton) {
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc
    private func saveLoginTap(sender: UIButton) {
        isSave.toggle()
    }
}

extension AuthorizationViewController: BaseViewDelegate {
    func didTapGoogle() {
//        GIDSignIn.sharedInstance.configuration?.prepareForInterfaceBuilder()
//        GIDSignIn.sharedInstance.si
    }
    
    func didTapPhone() {
        let vc = PhoneVerifViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}


