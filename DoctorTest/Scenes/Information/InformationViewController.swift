//
//  InformationViewController.swift
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

class InformationViewController: ViewController, BindableType {
    var viewModel: InformationViewModel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var faxTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var bankNameTextField: UITextField!
    @IBOutlet weak var bankAccountTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backToFillButton: UIButton!
    @IBOutlet weak var reviewModeButton: UIButton!
    
    @IBOutlet weak var personalCusButton: UIButton!
    @IBOutlet weak var companyCusButton: UIButton!
    
    @IBOutlet weak var receiptCodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var receipt: Receipt!
    private var isFilling: Bool = true
    
    private var receiptErrorBinder: Binder<Error> {
        return Binder(self) { vc, error in
            vc.showAlert(title: "Invalid barcode", message: "Your barcode is invalid. Please check")
        }
    }
    
    private var receiptBinder: Binder<Receipt> {
        return Binder(self) { vc, receipt in
            vc.receiptCodeLabel.text = receipt.displayCode
            vc.dateLabel.text = receipt.displayDate
            vc.totalLabel.text = receipt.displayTotal
        }
    }
    
    private var previewModeBinder: Binder<Bool> {
        return Binder(self) { vc, isPreviewing in
            vc.reviewModeButton.isHidden = !isPreviewing
            vc.nameTextField.isEnabled = !isPreviewing
            vc.companyNameTextField.isEnabled = !isPreviewing
            vc.taxTextField.isEnabled = !isPreviewing
            vc.addressTextField.isEnabled = !isPreviewing
            vc.stateTextField.isEnabled = !isPreviewing
            vc.cityTextField.isEnabled = !isPreviewing
            vc.phoneTextField.isEnabled = !isPreviewing
            vc.faxTextField.isEnabled = !isPreviewing
            vc.emailTextField.isEnabled = !isPreviewing
            
            vc.bankNameTextField.isEnabled = !isPreviewing
            vc.bankAccountTextField.isEnabled = !isPreviewing
            vc.noteTextField.isEnabled = !isPreviewing
            
            vc.personalCusButton.isEnabled = !isPreviewing
            vc.companyCusButton.isEnabled = !isPreviewing
            
            if isPreviewing {
                vc.submitButton.isHidden = false
                vc.nextButton.isHidden = true
                vc.backToFillButton.isHidden = false
                vc.backButton.isHidden = true
            } else {
                vc.submitButton.isHidden = true
                vc.nextButton.isHidden = false
                vc.backToFillButton.isHidden = true
                vc.backButton.isHidden = false
            }
        }
    }

    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = InformationViewModel.InputBuilder().then {
            $0.receiptTrigger = Observable.just(receipt).asDriverOnErrorJustComplete()
            $0.backTrigger = backButton.rx.tap.asDriverOnErrorJustComplete()
            $0.nextTrigger = nextButton.rx.tap.asDriverOnErrorJustComplete()
            $0.submitTrigger = submitButton.rx.tap.asDriverOnErrorJustComplete()
            $0.backToFillTrigger = backToFillButton.rx.tap.asDriverOnErrorJustComplete()
            
            $0.nameTrigger = nameTextField.rx.text.orEmpty.asDriver()
            $0.companyNameTrigger = companyNameTextField.rx.text.orEmpty.asDriver()
            $0.taxTrigger = taxTextField.rx.text.orEmpty.asDriver()
            $0.addressTrigger = addressTextField.rx.text.orEmpty.asDriver()
            $0.stateTrigger = stateTextField.rx.text.orEmpty.asDriver()
            $0.cityTrigger = cityTextField.rx.text.orEmpty.asDriver()
            $0.phoneTrigger = phoneTextField.rx.text.orEmpty.asDriver()
            $0.faxTrigger = faxTextField.rx.text.orEmpty.asDriver()
            $0.emailTrigger = emailTextField.rx.text.orEmpty.asDriver()
            $0.bankNameTrigger = bankNameTextField.rx.text.orEmpty.asDriver()
            $0.bankAccountTrigger = bankAccountTextField.rx.text.orEmpty.asDriver()
            $0.noteTrigger = noteTextField.rx.text.orEmpty.asDriver()
            $0.personalCusTrigger = Driver.merge(Driver.just(""), personalCusButton.rx.tap.map { "Personal" }.asDriverOnErrorJustComplete())
            $0.companyCusTrigger = Driver.merge(Driver.just(""), companyCusButton.rx.tap.map { "Company" }.asDriverOnErrorJustComplete())
        }
        
        let input = InformationViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.receipt
            .drive(receiptBinder)
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
        
        output.submit
            .drive()
            .disposed(by: disposeBag)
        
        output.preview
            .drive(previewModeBinder)
            .disposed(by: disposeBag)
        
        output.previewEnable
            .do(onNext: { isEnable in  self.nextButton.alpha = isEnable ? 1.0 : 0.4 })
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.error
            .drive(receiptErrorBinder)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension InformationViewController: StoryboardSceneBased {
    // TODO: Please add "Information" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
