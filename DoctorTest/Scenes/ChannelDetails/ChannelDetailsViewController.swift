//
//  ChannelDetailsViewController.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then
import WebKit

class ChannelDetailsViewController: ViewController, BindableType, WKUIDelegate {
    var viewModel: ChannelDetailsViewModel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var webView: UIView!
    var disposeBag: DisposeBag = DisposeBag()
    
    var mWebView: WKWebView!
    var channel: Channel!
    
    private var channelDetailBinder: Binder<Channel> {
        return Binder(self) { vc, channel in
            if let contentHTML = channel.contents {
                vc.mWebView.loadHTMLString(contentHTML, baseURL: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        mWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        mWebView.uiDelegate = self
        webView.addSubview(mWebView)
        mWebView.scrollView.showsHorizontalScrollIndicator = false
        mWebView.snp.makeConstraints { make in
            make.top.equalTo(self.webView)
            make.bottom.equalTo(self.webView)
            make.leading.equalTo(self.webView)
            make.trailing.equalTo(self.webView)
        }
        let navigator: ChannelDetailsNavigatorType = DefaultAssembler.shared.resolveNavigator(viewController: self)
        let interactor: ChannelDetailsInteractorType = DefaultAssembler.shared.resolveInteractor()
        self.viewModel = DefaultAssembler.shared.resolveViewModel(navigator: navigator, interactor: interactor)
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollSize = CGSize(width: webView.frame.size.width,
                                height: mWebView.scrollView.contentSize.height)
        mWebView.scrollView.contentSize = scrollSize
    }
    
    // MARK: BindableType
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initHeaderView()
    }
    
    func bindViewModel() {
        let inputBuilder = ChannelDetailsViewModel.InputBuilder().then {
            $0.channel = Driver.just(channel)
        }
        
        let input = ChannelDetailsViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.channelDetail
            .drive(channelDetailBinder)
            .disposed(by: disposeBag)
    }
    
    func initHeaderView() {
        let view = HeaderItemView()
        self.headerView.addSubview(view)
        view.frame = headerView.bounds
        view.snp.makeConstraints { make in
            make.top.equalTo(self.headerView)
            make.bottom.equalTo(self.headerView)
            make.leading.equalTo(self.headerView)
            make.trailing.equalTo(self.headerView)
        }
    }
}

extension ChannelDetailsViewController: StoryboardSceneBased {
    // TODO: Please add "ChannelDetails" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}
