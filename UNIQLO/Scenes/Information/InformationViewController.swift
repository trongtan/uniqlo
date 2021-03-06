//
//  InformationViewController.swift
//  Uniqlo
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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: NSLayoutConstraint!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var addressLabel: NSLayoutConstraint!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
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
    
    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var nameRequiredMark: UILabel!
    @IBOutlet weak var companyNameRequiredMark: UILabel!

    var receipt: Receipt!
    private var isFilling: Bool = true

//    private var isBusinessSubject: PublishSubject<Bool> = PublishSubject()
    
//    private var receiptErrorBinder: Binder<Error> {
//        return Binder(self) { vc, error in
//            vc.showAlert(title: "Invalid barcode", message: "Your barcode is invalid. Please check")
//        }
//    }
    
    private var receiptBinder: Binder<Receipt> {
        return Binder(self) { vc, receipt in
            vc.receiptCodeLabel.text = receipt.displayCode
            vc.dateLabel.text = receipt.displayDate
            vc.totalLabel.text = receipt.displayTotal
            
            vc.nameTextField.text = receipt.name
            vc.companyNameTextField.text = receipt.legalName
            vc.taxTextField.text = receipt.taxCode
            vc.addressTextField.text = receipt.address
            vc.phoneTextField.text = receipt.phone
            vc.bankAccountTextField.text = receipt.bankAccount
            vc.bankNameTextField.text = receipt.bankName
            vc.noteTextField.text = receipt.notes
            vc.emailTextField.text = receipt.email
            vc.faxTextField.text = receipt.fax

            if receipt.isBusiness {
                vc.hightlightCompanyButton()
            } else {
                vc.hightlightPersonalButton()
            }
        }
    }
    
    private var previewModeBinder: Binder<Bool> {
        return Binder(self) { vc, isPreviewing in
            vc.reviewModeButton.isHidden = !isPreviewing
            vc.nameTextField.isEnabled = !isPreviewing
            vc.companyNameTextField.isEnabled = !isPreviewing
            vc.taxTextField.isEnabled = !isPreviewing
            vc.addressTextField.isEnabled = !isPreviewing
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

    private var personalButtonBinder: Binder<Bool> {
        return Binder(self) { vc, _ in
            vc.hightlightPersonalButton()
        }
    }

    private var companyButtonBinder: Binder<Bool> {
        return Binder(self) { vc, _ in
            vc.hightlightCompanyButton()
        }
    }

    private func hightlightCompanyButton() {
        personalCusButton.tintColor = .lightGray
        companyCusButton.tintColor = Constants.Colors.uniqlo
        personalCusButton.setTitleColor(Constants.Colors.textColor, for: .normal)
        companyCusButton.setTitleColor(Constants.Colors.uniqlo, for: .normal)

        nameRequiredMark.isHidden = true
        companyNameRequiredMark.isHidden = false
    }

    private func hightlightPersonalButton() {
        companyCusButton.tintColor = .lightGray
        personalCusButton.tintColor = Constants.Colors.uniqlo
        personalCusButton.setTitleColor(Constants.Colors.uniqlo, for: .normal)
        companyCusButton.setTitleColor(Constants.Colors.textColor, for: .normal)

        nameRequiredMark.isHidden = false
        companyNameRequiredMark.isHidden = true
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
            $0.phoneTrigger = phoneTextField.rx.text.orEmpty.asDriver()
            $0.faxTrigger = faxTextField.rx.text.orEmpty.asDriver()
            $0.emailTrigger = emailTextField.rx.text.orEmpty.asDriver()
            $0.bankNameTrigger = bankNameTextField.rx.text.orEmpty.asDriver()
            $0.bankAccountTrigger = bankAccountTextField.rx.text.orEmpty.asDriver()
            $0.noteTrigger = noteTextField.rx.text.orEmpty.asDriver()
            $0.personalButtonTrigger = personalCusButton.rx.tap.asDriverOnErrorJustComplete()
            $0.businessButtonTrigger = companyCusButton.rx.tap.asDriverOnErrorJustComplete()
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
            .drive(errorBinder)
            .disposed(by: disposeBag)
        
        output.activityIndicator
            .drive(activityIndicatorViewBinder)
            .disposed(by: disposeBag)
        
        output.isBusiness
            .drive(self.companyNameTextField.rx.isEnabled)
            .disposed(by: disposeBag)

        output.validateErrorMessage
            .drive(self.errorLabel.rx.text)
            .disposed(by: disposeBag)

        output.personalButton
            .debug()
            .drive(personalButtonBinder)
            .disposed(by: disposeBag)

        output.companyButton
            .debug()
            .drive(companyButtonBinder)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.backgroundColor = Constants.Colors.uniqlo
        self.backButton.backgroundColor = Constants.Colors.uniqlo
        self.submitButton.backgroundColor = Constants.Colors.uniqlo
        self.backToFillButton.backgroundColor = Constants.Colors.uniqlo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension InformationViewController: StoryboardSceneBased {
    // TODO: Please add "Information" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.uniqlo.instance
}
