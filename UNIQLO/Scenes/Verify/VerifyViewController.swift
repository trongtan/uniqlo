//
//  VerifyViewController.swift
//  Uniqlo
//
//  Created by tan vu on 8/2/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then

class VerifyViewController: ViewController, BindableType {
    var viewModel: VerifyViewModel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.backgroundColor = Constants.Colors.uniqlo
        self.nextButton.backgroundColor = Constants.Colors.uniqlo
        
        #if DEBUG
        self.passwordTextField.text = Constants.Configs.defaultPassword
        #endif
        
    }
    
    func bindViewModel() {
        let inputBuilder = VerifyViewModel.InputBuilder().then {
            $0.dismissTrigger = backButton.rx.tap.asDriver()
            $0.verifyTrigger = nextButton.rx.tap.asDriver()
            $0.password = passwordTextField.rx.text.orEmpty.asDriver()
        }
        
        let input = VerifyViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.verify
            .drive()
            .disposed(by: disposeBag)
        
        output.dismiss
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: disposeBag)
    }
}

extension VerifyViewController: StoryboardSceneBased {
    // TODO: Please add "Verify" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.uniqlo.instance
}
