//
//  ViewController.swift
//  DoctorTest
//
//  Created by tan vu on 7/20/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        
        self.view.rx.tapGesture().subscribe(onNext: { _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Restore the navigation bar to default
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
    }
}

extension ViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultButton)
        self.present(alert, animated: true, completion: nil)
    }
}
