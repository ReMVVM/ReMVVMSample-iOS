//  
//  ToDoListViewController.swift
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

class ToDoListViewController: EXBaseViewController {

    @ReMVVM.ViewModel private var mainViewModel: ToDoListViewModel?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: ToDoListViewModel) {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
    }

    private func bindView(with viewModel: ToDoListViewModel) {

    }

}
