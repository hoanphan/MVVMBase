//
//  LoginController.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = LoginViewModel(service: MVVMService())
        let source = LoginViewModel.Source(viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
                                           loginAction: btnLogin.rx.tap.asDriver(),
                                           email: self.emailComonTextField.textField.rx.text.orEmpty.asDriver(),
                                           password: self.passwordCommonTextField.textField.rx.text.orEmpty.asDriver())
        let sink = viewModel.transform(source: source)
        self.bindData(sink)
    }

    // demo
    override func localizable() {
        self.passwordCommonTextField.getCommonTextField().placeholder = L10n.tr("login.password")
        self.emailComonTextField.getCommonTextField().placeholder = L10n.tr("login.email")
        btnLogin.setTitle(L10n.tr("login.login"), for: .normal)
    }

    override func setupView() {
        self.emailComonTextField.getCommonTextField().then {
            $0.keyboardType = .emailAddress
            $0.icon = R.image.account()
        }

        self.passwordCommonTextField.getCommonTextField().then {
            $0.keyboardType = .default
            $0.isSecurityField = true
            $0.icon = R.image.icon_password()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        if let sink = sink as? LoginViewModel.Sink {
            sink.loginResponse.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    openFromRootView(R.storyboard.main.instantiateInitialViewController())
                }).disposed(by: disposeBag)

            sink.validationEmail
                .delay(.milliseconds(200))
                .asObservable()
                .subscribe(onNext: {[weak self] (isValid, message) in
                    if isValid == false {
                        self?.emailComonTextField.setStateTextField(state: .error(message))
                    }
                    self?.view.layoutIfNeeded()
                }).disposed(by: disposeBag)

            sink.validationPassword
                .delay(.milliseconds(200))
                .asObservable()
                .subscribe(onNext: {[weak self] (isValid, message) in
                    if isValid == false {
                        self?.passwordCommonTextField.setStateTextField(state: .error(message))
                    }
                     self?.view.layoutIfNeeded()
                }).disposed(by: disposeBag)

            self.btnLogin.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.view.endEditing(true)
                }).disposed(by: disposeBag)
        }
    }

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var emailComonTextField: CommonTextFieldError!
    @IBOutlet weak var passwordCommonTextField: CommonTextFieldError!
}
