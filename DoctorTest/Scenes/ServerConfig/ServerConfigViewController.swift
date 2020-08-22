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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextField.text = UserDefaults.standard.value(forKey: Constants.Key.serverURL) as? String ?? ""
        self.portTextField.text = UserDefaults.standard.value(forKey: Constants.Key.serverPort) as? String ?? ""
        
        self.saveButton.backgroundColor = Constants.Colors.uniqlo
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
//            .do(onNext: {
//                self.checkIsConnectedToNetwork()
//            })
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: disposeBag)
    }
    
//    func checkIsConnectedToNetwork() {
//        let hostUrl: String = "\(UserDefaults.serverURL):\(UserDefaults.serverPort)"
//       if let url = URL(string: hostUrl) {
//          var request = URLRequest(url: url)
//          request.httpMethod = "HEAD"
//          URLSession(configuration: .default)
//          .dataTask(with: request) { (_, response, error) -> Void in
//             guard error == nil else {
//                print("Error:", error ?? "")
//                return
//             }
//             guard (response as? HTTPURLResponse)?
//             .statusCode == 200 else {
//                print("The host is down")
//                return
//             }
//             print("The host is up and running")
//          }
//          .resume()
//       }
//    }
}

extension ServerConfigViewController: StoryboardSceneBased {
    // TODO: Please add "ServerConfig" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
