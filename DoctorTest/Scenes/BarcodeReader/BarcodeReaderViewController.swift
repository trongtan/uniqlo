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
    
    @IBOutlet weak var barCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var previewView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton!
    var scanner: MTBBarcodeScanner?
    
    private var receiptErrorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.showAlert(title: "Invalid barcode", message: "Your barcode is invalid. Please check")
        }
    }
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
            .drive(receiptErrorBinder)
            .disposed(by: disposeBag)
        
        output.logout
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = MTBBarcodeScanner(previewView: self.previewView)
        self.nextButton.backgroundColor = Constants.Colors.uniqlo
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
                                self.barCodeTextField.text = stringValue
                                print("Found code: \(stringValue)")
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                self.showAlert(title: "Scanning Unavailable", message: "This app does not have permission to access the camera")
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        
        super.viewWillDisappear(animated)
        self.barCodeTextField.text = ""
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.scanner?.refreshVideoOrientation()
        })
    }
}

extension BarcodeReaderViewController: StoryboardSceneBased {
    // TODO: Please add "BarcodeReader" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
