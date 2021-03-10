//
//  CommonTextFieldError.swift
//  BaseMVVM
//
//  Created by HOANDHTB on 3/11/21.
//

import UIKit
import SnapKit

class CommonTextFieldError: UIView {
    fileprivate var commonTextField = CommonTextField()
    fileprivate var labelError = UILabel()
    fileprivate var stateTextField: CommonTextField.State = .normal

    var textField: UITextField {
        return self.commonTextField.textField
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }

    fileprivate func initView() {
        self.commonTextField.delegate = self
        self.contraitTextField()
        self.labelError.then {
            $0.textColor = R.color.errorBorderInput()
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.text = ""
        }
    }

    fileprivate func contraitTextField() {
        self.addSubview(commonTextField)
        switch stateTextField {
        case .active, .normal:
            commonTextField.snp.makeConstraints { make in
                make.trailing.leading.top.bottom.equalTo(0)
                make.height.equalTo(40)
            }
        case .error:
            commonTextField.snp.makeConstraints { make in
                make.trailing.leading.top.equalTo(0)
                make.height.equalTo(40)
            }
        }
    }

    fileprivate func contraintLabelError() {
        self.addSubview(self.labelError)
        self.labelError.snp.makeConstraints { make in
            make.top.equalTo(self.commonTextField.snp.bottom).offset(5)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.bottom.equalTo(-5)
        }
    }

    func setStateTextField(state: CommonTextField.State) {
        self.commonTextField.state = state
        self.stateTextField = state

        switch state {
        case .active, .normal:
            self.labelError.removeFromSuperview()
        case .error(let error):
            self.commonTextField.removeFromSuperview()
            self.contraitTextField()
            self.labelError.text = error
            self.contraintLabelError()
        }
    }

    public func getCommonTextField() -> CommonTextField {
        return commonTextField
    }
}

extension CommonTextFieldError: CommonTextFieldDelegate {
    func changeState(state: CommonTextField.State) {
        self.setStateTextField(state: state)
    }
}
