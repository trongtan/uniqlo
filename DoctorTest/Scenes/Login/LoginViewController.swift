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
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var configButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.backgroundColor = Constants.Colors.uniqlo
        
        #if DEBUG
        self.emailTextField.text = "1243934" //1441859
        self.passwordTextField.text = "965250" //0920
        #endif
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
            .drive(errorBinder)
            .disposed(by: disposeBag)
        
        output.verifyServerConfig
            .drive()
            .disposed(by: disposeBag)
        
        output.activityIndicator
            .drive(activityIndicatorViewBinder)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        initServerConfig()
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

extension LoginViewController {
    private func initServerConfig() {
        if let serverURL = UserDefaults.serverURL as? String, serverURL.isEmpty {
            self.showAlert(title: "Error", message: "Please config your server.")
        }
    }
}
