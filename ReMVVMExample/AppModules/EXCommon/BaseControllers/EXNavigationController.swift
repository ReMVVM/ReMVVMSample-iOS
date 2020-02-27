//
//  EXNavigationController.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import UIKit

class EXNavigationController: UINavigationController {

    private let backButton = { return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) }()

    override public var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.last?.navigationItem.backBarButtonItem = backButton
        super.setViewControllers(viewControllers, animated: animated)
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let viewController = self.topViewController {
            viewController.navigationItem.backBarButtonItem = backButton
        }
        super.pushViewController(viewController, animated: animated)
    }

}
