//
//  EverfitInteractor.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//  Copyright (c) 2020 . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginInteractorType: InteractorType {
    func validateEmail(email: String) -> (isValid: Bool, message: String)
    func validatePassword(pass: String) -> (isValid: Bool, message: String)
    func login(email: String, password: String) -> Observable<Void>
    func verifyServerConfig(password: String) -> Observable<Void>
    
}

struct LoginInteractor: LoginInteractorType {
    let usecase: NetworkUseCaseType
    
    func validateEmail(email: String) -> (isValid: Bool, message: String) {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
//        return (emailPred.evaluate(with: email), "")
        return (!email.isEmpty, "")
    }
    
    func validatePassword(pass: String) -> (isValid: Bool, message: String) {
        return (!pass.isEmpty, "")
    }
    
    func login(email: String, password: String) -> Observable<Void> {
        return usecase.login(email: email, password: password).mapToVoid()
    }
    
    func verifyServerConfig(password: String) -> Observable<Void> {
        return usecase.verifyServerConfig(password: password)
    }
}
