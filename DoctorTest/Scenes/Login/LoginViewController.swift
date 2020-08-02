//
//  LoginViewController.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//  Copyright (c) 2020 . All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then
import RxGesture
import SnapKit

class LoginViewController: ViewController, BindableType {
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var configButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var loginErrorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.showAlert(title: "Error", message: "\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.backgroundColor = Constants.Colors.uniqlo
    }
    
    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = LoginViewModel.InputBuilder().then {
            $0.emailTrigger = emailTextField.rx.text.orEmpty.asDriver()
            $0.passwordTrigger = passwordTextField.rx.text.orEmpty.asDriver()
            $0.loginButtonTrigger = loginButton.rx.tap.asDriver()
            $0.configButtonTrigger = configButton.rx.tap.asDriver()
        }
        
        let input = LoginViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.loginEnable
            .do(onNext: { isEnable in  self.loginButton.alpha = isEnable ? 1.0 : 0.4 })
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.login
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(loginErrorBinder)
            .disposed(by: disposeBag)
        
        output.verifyServerConfig
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
