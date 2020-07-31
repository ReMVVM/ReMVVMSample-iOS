//  
//  ProfileViewController.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVM
import ReMVVMExt
import RxCocoa
import RxSwift
import UIKit

class ProfileViewController: EXBaseViewController {

    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var onboardingButton: UIButton!
    @IBOutlet private var logoutButton: UIButton!

    @Provided private var mainViewModel: ProfileViewModel?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: ProfileViewModel) {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.logoutTitle.bind(to: logoutButton.rx.title()).disposed(by: disposeBag)
        viewModel.welcomeText.bind(to: welcomeLabel.rx.text).disposed(by: disposeBag)
        viewModel.showOnboardingTitle.bind(to: onboardingButton.rx.title()).disposed(by: disposeBag)
        viewModel.isLoggedIn.map { !$0 }.bind(to: logoutButton.rx.isHidden).disposed(by: disposeBag)
    }

    private func bindView(with viewModel: ProfileViewModel) {
        logoutButton.rx.tap.bind(to: viewModel.logoutSubject).disposed(by: disposeBag)
        onboardingButton.rx.tap.map { ShowOnboardingAction() }.bind(to: remvvm.rx).disposed(by: disposeBag)
    }

}
