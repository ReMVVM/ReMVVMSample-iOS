//
//  AppDelegate.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 20/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppConfigurator.setupAplication(with: .empty)

        return true
    }

}


//Icons made by <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
