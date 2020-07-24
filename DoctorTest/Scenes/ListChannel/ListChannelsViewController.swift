//
//  ListChannelsViewController.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then
import Nuke

class ListChannelsViewController: ViewController, BindableType {
    var viewModel: ListChannelsViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var currentSelectedFilterIndexPath = IndexPath(row: 0, section: 0)
    
    private var channelCategories: [ChannelCategory] = []
    private var channels: [Channel] = []
    
    private var changeCategoryTrigger: PublishSubject<ChannelCategory> = PublishSubject()
    private var toChannelDetail: PublishSubject<Channel> = PublishSubject()
    
    private var channelCategoryBinder: Binder<[ChannelCategory]> {
        return Binder(self) { vc, channelCategories in
            vc.channelCategories = channelCategories
            vc.channelCategories.insert(ChannelCategory.allChannelType, at: 0)
            vc.collectionView.reloadData()
        }
    }
    
    private var channelsBinder: Binder<[Channel]> {
          return Binder(self) { vc, channels in
              vc.channels = channels
              vc.tableView.reloadData()
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigator: ListChannelsNavigatorType = DefaultAssembler.shared.resolveNavigator(viewController: self)
        let interactor: ListChannelsInteractorType = DefaultAssembler.shared.resolveInteractor()
        self.viewModel = DefaultAssembler.shared.resolveViewModel(navigator: navigator, interactor: interactor)
        bindViewModel()
        
        tableView.tableFooterView = UIView()
    }
    // MARK: BindableType
    
    func bindViewModel() {
        let inputBuilder = ListChannelsViewModel.InputBuilder().then {
            $0.changeCategoryTrigger = changeCategoryTrigger.asDriverOnErrorJustComplete()
            $0.toChannelDetail = toChannelDetail.asDriverOnErrorJustComplete()
        }
        
        let input = ListChannelsViewModel.Input(builder: inputBuilder)
        let output = viewModel.transform(input)
        
        output.channelCategories
            .drive(channelCategoryBinder)
            .disposed(by: disposeBag)
        
        output.channels
        .drive(channelsBinder)
        .disposed(by: disposeBag)
        
        output.toChannelDetail
        .drive()
        .disposed(by: disposeBag)
    }
}

extension ListChannelsViewController: StoryboardSceneBased {
    // TODO: Please add "ListChannels" to AppStoryboard enum
    // and remove me when you done.
    static var sceneStoryboard = AppStoryboard.appDoctor.instance
}

extension ListChannelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell
        let channel = channels[indexPath.row]
        cell.setup(for: channel)
        
//        if let url = URL(string: channel.imgPath) {
//                   let request = ImageRequest(
//                       url: url,
//                       processors: [ImageProcessors.Resize(size: cell.headerView.itemImageView.bounds.size)],
//                       priority: .high
//                   )
//                   Nuke.loadImage(with: request, into: cell.headerView.itemImageView)
//               }
        return cell
    }
}

extension ListChannelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc: ChannelDetailsViewController = DefaultAssembler.shared.resolveViewController()
//        navigationController?.pushViewController(vc, animated: true)
        self.toChannelDetail.onNext(channels[indexPath.row])
    }
}


extension ListChannelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuCollectionViewCell
        cell.nameLabel.text = channelCategories[indexPath.row].categoryName
        if indexPath == currentSelectedFilterIndexPath {
            cell.nameLabel.textColor = UIColor(hex: "#1db7b6")
        }
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == currentSelectedFilterIndexPath { return }
        
        if let previousCell = collectionView.cellForItem(at: currentSelectedFilterIndexPath) as? MenuCollectionViewCell {
            previousCell.nameLabel.textColor = UIColor(hex: "#202020")
        }

        
        let cell = collectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
        cell.nameLabel.textColor = UIColor(hex: "#1db7b6")
        
        
        currentSelectedFilterIndexPath = indexPath
        
        self.changeCategoryTrigger.onNext(self.channelCategories[indexPath.row])
    }
}
