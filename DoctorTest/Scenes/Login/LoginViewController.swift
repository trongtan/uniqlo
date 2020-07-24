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

class LoginViewController: ViewController, BindableType {
    var viewModel: LoginViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    var trainingDays: [TrainingDay] = []
    
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var getTrainingBinder: Binder<Login> {
        return Binder(self) { vc, login in
        }
    }
    
    private var loginErrorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            vc.show(alert, sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        // TEST
        self.emailTextField.text = "ttt@gmail.com"
        self.passwordTextField.text = "12122012gv!"
        
        self.view.rx.tapGesture().subscribe(onNext: { _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: BindableType
    
    func bindViewModel() {
        let navigator: LoginNavigatorType = DefaultAssembler.shared.resolveNavigator(viewController: self)
        let interactor: LoginInteractorType = DefaultAssembler.shared.resolveInteractor()
        self.viewModel = DefaultAssembler.shared.resolveViewModel(navigator: navigator, interactor: interactor)
        
        let inputBuilder = LoginViewModel.InputBuilder().then {
            $0.emailTrigger = emailTextField.rx.text.orEmpty.asDriver()
            $0.passwordTrigger = passwordTextField.rx.text.orEmpty.asDriver()
            $0.loginButtonTrigger = loginButton.rx.tap.asDriver()
        }

        let input = LoginViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)

        output.loginEnable
            .do(onNext: { isEnable in  self.loginButton.alpha = isEnable ? 1.0 : 0.4 })
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.login
            .drive(getTrainingBinder)
            .disposed(by: disposeBag)
        
        output.error
            .drive(loginErrorBinder)
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
