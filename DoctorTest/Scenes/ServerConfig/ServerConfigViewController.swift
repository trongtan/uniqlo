//
//  ServerConfigViewController.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then

class ServerConfigViewController: ViewController, BindableType {
    var viewModel: ServerConfigViewModel!
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var errorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.showAlert(title: "Error", message: "\(error)")
        }
    }
    
    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = ServerConfigViewModel.InputBuilder().then {
            $0.serverURLTrigger = urlTextField.rx.text.orEmpty.asDriver()
            $0.serverPortTrigger = portTextField.rx.text.orEmpty.asDriver()
            $0.saveTrigger = saveButton.rx.tap.asDriverOnErrorJustComplete()
        }
        
        let input = ServerConfigViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.save
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: disposeBag)
    }
}

extension ServerConfigViewController: StoryboardSceneBased {
    // TODO: Please add "ServerConfig" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}