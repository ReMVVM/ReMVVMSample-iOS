//  
//  OnboardingViewController.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 24/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt
import RxCocoa
import RxSwift
import UIKit

class OnboardingViewController: EXBaseViewController {

    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var homeButton: UIButton!

    @Provided private var mainViewModel: OnboardingViewModel?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: OnboardingViewModel) {

        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.homeTitle.bind(to: homeButton.rx.title()).disposed(by: disposeBag)
        viewModel.loginTitle.bind(to: loginButton.rx.title()).disposed(by: disposeBag)
        viewModel.isLoggedIn.bind(to: loginButton.rx.isHidden).disposed(by: disposeBag)

    }

    private func bindView(with viewModel: OnboardingViewModel) {

        loginButton.rx.tap.map { ShowLoginAction() }.bind(to: remvvm.rx).disposed(by: disposeBag)
        homeButton.rx.tap.map { ShowTestStackAction.showOnTab }.bind(to: remvvm.rx).disposed(by: disposeBag)

    }

}
