//  
//  ToDoItemViewController.swift
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

class ToDoItemViewController: EXBaseViewController {

    @Provided private var mainViewModel: ToDoItemViewModel?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: ToDoItemViewModel) {

    }

    private func bindView(with viewModel: ToDoItemViewModel) {

    }

}
