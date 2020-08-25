//
//  BarcodeReaderViewController.swift
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
import MTBBarcodeScanner

class BarcodeReaderViewController: ViewController, BindableType {
    var viewModel: BarcodeReaderViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var previewView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton!
    var scanner: MTBBarcodeScanner?
    
    @IBOutlet weak var fillDebugButton: UIButton!
    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = BarcodeReaderViewModel.InputBuilder().then {
            $0.barcodeTrigger = barCodeTextField.rx.text.orEmpty.asDriver()
            $0.nextButtonTrigger = nextButton.rx.tap.asDriver()
            $0.logoutButtonTrigger = logoutButton.rx.tap.asDriver()
        }
        
        let input = BarcodeReaderViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.nextButtonEnable
            .do(onNext: { isEnable in  self.nextButton.alpha = isEnable ? 1.0 : 0.4 })
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.next
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: disposeBag)
        
        output.logout
            .drive()
            .disposed(by: disposeBag)
        
        output.activityIndicator
            .drive(activityIndicatorViewBinder)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: self.previewView)
        self.nextButton.backgroundColor = Constants.Colors.uniqlo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        fillDebugButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.barCodeTextField.rxSetText(text: "66202005291727060009010007")
        }).disposed(by: disposeBag)

        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                self.barCodeTextField.rxSetText(text: stringValue)
                                print("Found code: \(stringValue)")
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                self.showAlert(title: "Error".localization, message: "This app does not have permission to access the camera".localization)
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        
        super.viewWillDisappear(animated)
        resetUI()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.scanner?.refreshVideoOrientation()
        })
    }
    
    private func resetUI() {
        self.barCodeTextField.rxSetText(text: "")
    }
}

extension BarcodeReaderViewController: StoryboardSceneBased {
    // TODO: Please add "BarcodeReader" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
