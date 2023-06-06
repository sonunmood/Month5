//
//  AuthorizationManager.swift
//  Month5-1
//
//  Created by Sonun on 5/6/23.
//

import UIKit
import FirebaseAuth

class AuthorizationManager {
    
    
    private let auth = Auth.auth()
    private let provider = PhoneAuthProvider.provider()
    private var verificationID: String?
    private let keyChain = KeyChainManager.shared
    private let userDefault = UserDefaults.standard
    
    static let shared = AuthorizationManager()
    
    func verificationPhoneNumber(phoneNumber: String, completion: @escaping(Result<Void, Error>) -> Void) {
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(.failure(error!))
                return
            }
            self.userDefault.set(verificationID, forKey: Constants.Auth.verificationID)
            completion(.success(()))
        }
    }
    
    func tryToLogin(smsCode: String, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let verificationID = userDefault.string(forKey: Constants.Auth.verificationID) else {
            return
        }
        let credential = provider.credential(
            withVerificationID: verificationID,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            guard let _ = result, error == nil else {
                completion(.failure(error!))
                return
            }
            if self.auth.currentUser != nil {
                self.saveSession()
                completion(.success(()))
            }
        }
    }
    
    private func saveSession() {
        let minuteLater = Calendar.current.date(byAdding: .second, value: 60, to: Date())!
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let data = try! encoder.encode(minuteLater)
        self.keyChain.save(data, service: Constants.keyChain.service, account: Constants.keyChain.account)
    }
    

}
