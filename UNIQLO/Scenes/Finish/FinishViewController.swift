//
//  FinishViewController.swift
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

class FinishViewController: ViewController, BindableType {
    var viewModel: FinishViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finishImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.backgroundColor = Constants.Colors.uniqlo
        finishImageView.tintColor = Constants.Colors.uniqlo
    }
    
    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = FinishViewModel.InputBuilder().then {
            $0.backTrigger = backButton.rx.tap.asDriverOnErrorJustComplete()
        }
        
        let input = FinishViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
    }
}

extension FinishViewController: StoryboardSceneBased {
    // TODO: Please add "Finish" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.uniqlo.instance
}
