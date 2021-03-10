//
//  CommonTextField.swift
//  BaseMVVM
//
//  Created by HOANDHTB on 3/10/21.
//

import UIKit
import SnapKit

protocol CommonTextFieldDelegate {
    func changeState(state: CommonTextField.State)
}

@IBDesignable
class CommonTextField: UIView {
    // MARK: variable
    fileprivate var isShowPassword:Bool = false
    public var delegate: CommonTextFieldDelegate?
    
    // MARK: UI controller
    fileprivate var iconLeft:UIImageView?
    fileprivate var iconRight:UIImageView?
    public var textField:UITextField = UITextField()
    fileprivate var normalRadiusColor: CGColor = R.color.borderInput()?.cgColor ?? UIColor.white.cgColor
    fileprivate var activeRadiusColor: CGColor = R.color.activeBorderInput()?.cgColor ?? UIColor.blue.cgColor
    fileprivate var errorRadiusColor: CGColor = R.color.errorBorderInput()?.cgColor ?? UIColor.red.cgColor
    
    @IBInspectable
    public var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }

    @IBInspectable
    public var placeholder: String? {
        set {
            self.textField.placeholder = newValue
        }
        get {
            return self.textField.placeholder
        }
    }

    @IBInspectable
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            self.textField.keyboardType = keyboardType
        }
    }

    @IBInspectable
    public var isSecurityField: Bool = false {
        didSet {
            self.iconRight?.removeFromSuperview()
            self.textField.removeFromSuperview()
            self.setupIconRight()
            self.setupTextField()
        }
    }

    var state: State = .normal {
        didSet {
            self.setupBorderTextField()
        }
    }
    
    @IBInspectable
    var icon: UIImage? = UIImage(named: "account") {
        didSet {
            guard let icon = self.icon else {
                return
            }
            self.iconLeft?.image = icon
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    fileprivate func initView() {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        self.setupBorderTextField()

        // icon left
        self.iconLeft = UIImageView()
        iconLeft?.image = self.icon ?? UIImage()
        self.addSubview(self.iconLeft!)
        iconLeft?.snp.makeConstraints({ make in
            make.width.height.equalTo(17)
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(10)
        })

        self.setupIconRight()
        self.setupTextField()
    }

    fileprivate func setupBorderTextField() {
        switch self.state {
        case .normal:
            layer.borderColor = self.normalRadiusColor
        case .active:
            layer.borderColor = self.activeRadiusColor
        default:
            layer.borderColor = self.errorRadiusColor
        }
    }

    // MARK: setup UI icon right
    @discardableResult
    fileprivate func setupIconRight() -> UIView? {
        if !self.isSecurityField {
            self.iconRight?.removeFromSuperview()
            return nil
        }

        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }

        self.iconRight = UIImageView()
        self.iconRight?.image = UIImage(named: "icon_eye") ?? UIImage()
        view.addSubview(self.iconRight!)
        iconRight?.snp.makeConstraints({ make in
            make.width.height.equalTo(17)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.centerY.equalTo(self)
        })

        let button = UIButton()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(0)
        }

        button.addTarget(self, action:#selector(self.showOrHidePassword), for: .touchUpInside)

        return view
    }

    @objc func showOrHidePassword(_ sender: Any) {
        self.isShowPassword = !self.isShowPassword
        if self.isShowPassword {
            self.textField.isSecureTextEntry = false
            self.iconRight?.image = UIImage(named: "icon_invisible_eye") ?? UIImage()
            return
        }

        self.textField.isSecureTextEntry = true
        self.iconRight?.image = UIImage(named: "icon_eye") ?? UIImage()
    }

    // MARK: setup UI textfield
    fileprivate func setupTextField() {
        self.textField.text = self.text
        self.textField.placeholder = self.placeholder
        self.textField.isSecureTextEntry = self.isSecurityField
        self.textField.keyboardType = self.keyboardType
        textField.font = UIFont.systemFont(ofSize: 12)
        self.textField.delegate = self
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints({ makes in
            makes.leading.equalTo(self.iconLeft!.snp.trailing).offset(10)
            makes.top.equalTo(5)
            makes.bottom.equalTo(-5)
            if(self.isSecurityField) {
                makes.trailing.equalTo(self.iconRight!.snp.leading).offset(-10)
                return
            }

            makes.trailing.equalTo(-10)
        })
    }
    
    enum State{
        case normal
        case active
        case error(_ message: String)
    }
}

extension CommonTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.state = .active
        self.delegate?.changeState(state: .active)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.state = .normal
        self.delegate?.changeState(state: .normal)
    }
}
