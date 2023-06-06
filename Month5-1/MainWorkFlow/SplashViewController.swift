//
//  SplashViewController.swift
//  Month5-1
//
//  Created by Sonun on 6/6/23.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let keyChain = KeyChainManager.shared
    private let encoder = JSONEncoder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        if
            let data = keyChain.read(with: Constants.keyChain.service, Constants.keyChain.account
            ),
            let data = try? decoder.decode(Date.self, from: data),
            data > Date() {
            handleAuthorizedFlow()
        } else {
            handleNotAuthorizedFlow()
        }
    }
    
    private func handleNotAuthorizedFlow() {
        let vc = AuthorizationViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func handleAuthorizedFlow() {
        let vc = MainViewController()
        self.present(
            vc,
            animated: false
        )
    }
}
