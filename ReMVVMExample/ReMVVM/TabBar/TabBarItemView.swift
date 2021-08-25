//
//  TabBarItemView.swift
//  BNUICommon
//
//  Created by Grzegorz Jurzak on 13/02/2019.
//  Copyright © 2019 HYD. All rights reserved.
//

import Loaders
import RxCocoa
import RxSwift
import UIKit

open class TabBarItemView: UIControl {

    var title: String? = nil { didSet { setup() } }
    var iconImage: UIImage? = nil { didSet { setup() } }
    var iconImageActive: UIImage? = nil { didSet { setup() } }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!

    open override var isSelected: Bool { didSet { setup() } }

    func setup() {
        iconImageView.image = isSelected ? iconImageActive ?? iconImage : iconImage
        let title = self.title ?? ""
        titleLabel.text = isSelected ? "S " + title : title
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
