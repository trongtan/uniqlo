//
//  Storyboard.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/2/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    case appDoctor

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalizingFirstLetter(), bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return (instance.instantiateViewController(withIdentifier: storyboardID) as? T) ?? T()
    }

    func initViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
