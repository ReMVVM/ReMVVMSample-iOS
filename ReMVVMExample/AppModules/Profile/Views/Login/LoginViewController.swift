//  
//  LoginViewController.swift
//  ReMVVMExample
//
//  Created by Grzegorz Jurzak on 27/01/2020.
//  Copyright © 2020 MOBIGREG. All rights reserved.
//

import ReMVVMCore
import ReMVVMExt
import RxCocoa
import RxSwift
import UIKit

class LoginViewController: EXBaseViewController {

    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var tryLoginButton: UIButton!

    @IBOutlet private var errorLabel: UILabel!

    @ReMVVM.ViewModel private var mainViewModel: LoginViewModel?
    @ReMVVM.Dispatcher private var dispatcher

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: LoginViewModel) {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.usernameLabel.bind(to: usernameLabel.rx.text).disposed(by: disposeBag)
        viewModel.passwordLabel.bind(to: passwordLabel.rx.text).disposed(by: disposeBag)
        viewModel.buttonTitle.bind(to: tryLoginButton.rx.title()).disposed(by: disposeBag)

        viewModel.result
            .startWith(.error(""))
            .map { result -> String? in
                if case .error(let error) = result { return error }
                return nil
            }
            .bind(to: errorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.result
            .compactMap { result -> StoreAction? in
                if case .success = result { return DismissModal() }
                return nil
            }
            .bind(to: _dispatcher.rx)
            .disposed(by: disposeBag)

    }

    private func bindView(with viewModel: LoginViewModel) {

        usernameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        tryLoginButton.rx.tap.bind(to: viewModel.loginSubject).disposed(by: disposeBag)
    }

}
