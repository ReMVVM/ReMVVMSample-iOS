//
//  TabBarItemView.swift
//  BNUICommon
//
//  Created by Grzegorz Jurzak on 13/02/2019.
//  Copyright © 2019 HYD. All rights reserved.
//

import Loaders
import ReMVVM
import ReMVVMExt
import RxCocoa
import RxSwift
import UIKit

open class TabBarItemView: UIControl, ReMVVMDriven {

    var viewModel: AnyNavigationTab? {
        didSet {
            guard let viewModel = self.viewModel else { return }

            titleLabel.text = viewModel.title
            isSelected = { isSelected }()
        }
    }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!

    open override var isSelected: Bool {
        didSet {
            guard let viewModel = self.viewModel else { return }
            iconImageView.image = isSelected ? UIImage(data: viewModel.iconImageActive) : UIImage(data: viewModel.iconImage)

            titleLabel.text = isSelected ? "S " : "" + viewModel.title
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }

    open func setupNib() {
        Nib.add(to: self)
    }

}
