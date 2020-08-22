//
//  ViewController.swift
//  DoctorTest
//
//  Created by tan vu on 7/20/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    var activityIndicatorView: UIActivityIndicatorView!
    
    var activityIndicatorViewBinder: Binder<Bool> {
        return Binder(self) { vc, isAnimating in
            isAnimating ? vc.activityIndicatorView.startAnimating() : vc.activityIndicatorView.stopAnimating()
            vc.activityIndicatorView.isHidden = !isAnimating
            vc.view.alpha = isAnimating ? 0.8 : 1
            vc.view.isUserInteractionEnabled = !isAnimating
        }
    }
    
    
    var errorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.showAlert(title: "Error".localization, message: "\(error)")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .large
        } else {
            activityIndicatorView.style = .gray
        }
        activityIndicatorView.color = Constants.Colors.uniqlo
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationItem.backBarButtonItem?.title = ""
        
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


extension String {
    var localization: String {
        return Bundle.main.localizedString(forKey: self, value: self, table: nil)
    }
}
