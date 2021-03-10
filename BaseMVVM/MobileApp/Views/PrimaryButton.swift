//
//  primaryButton.swift
//  BaseMVVM
//
//  Created by HOANDHTB on 3/11/21.
//

import UIKit

class PrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    fileprivate func initView() {
        backgroundColor = R.color.priamryButton()
        setTitleColor(UIColor.white, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
