//  
//  TestStackViewController.swift
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

class TestStackViewController: EXBaseViewController {

    @IBOutlet private var pushButton: UIButton!
    @IBOutlet private var modalButton: UIButton!
    @IBOutlet private var dismissModalButton: UIButton!

    @Provided private var mainViewModel: TestStackViewModel?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: TestStackViewModel) {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.isOnModal.map { !$0 }.bind(to: dismissModalButton.rx.isHidden).disposed(by: disposeBag)
        viewModel.dismissModalButtonTitle.bind(to: dismissModalButton.rx.title()).disposed(by: disposeBag)
        viewModel.pushButtonTitle.bind(to: pushButton.rx.title()).disposed(by: disposeBag)
        viewModel.modalButtonTitle.bind(to: modalButton.rx.title()).disposed(by: disposeBag)
    }

    private func bindView(with viewModel: TestStackViewModel) {

        pushButton.rx.tap.map { ShowTestStackAction.push }.bind(to: remvvm.rx).disposed(by: disposeBag)
        modalButton.rx.tap.map { ShowTestStackAction.showModal }.bind(to: remvvm.rx).disposed(by: disposeBag)
        dismissModalButton.rx.tap.map { DismissModal() }.bind(to: remvvm.rx).disposed(by: disposeBag)
    }

}
