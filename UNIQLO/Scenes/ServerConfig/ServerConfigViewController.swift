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
    
    @IBOutlet weak var serverPortLabel: UILabel!
    @IBOutlet weak var serverURLLabel: UILabel!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    private var configBinder: Binder<(serverURL: String, port: String)> {
        return Binder(self) { vc, configs in
            vc.urlTextField.text = configs.serverURL
            vc.portTextField.text = configs.port
        }
    }

    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = ServerConfigViewModel.InputBuilder().then {
            $0.serverURLTrigger = urlTextField.rx.text.orEmpty.asDriver()
            $0.serverPortTrigger = portTextField.rx.text.orEmpty.asDriver()
            $0.saveTrigger = saveButton.rx.tap.asDriverOnErrorJustComplete()
            $0.cancelTrigger = cancelButton.rx.tap.asDriverOnErrorJustComplete()
        }
        
        let input = ServerConfigViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)

        output.config
            .drive(configBinder)
            .disposed(by: disposeBag)

        output.save
            .drive()
            .disposed(by: disposeBag)

        output.cancel
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
