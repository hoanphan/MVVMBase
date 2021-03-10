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
        viewModel = LoginViewModel(service: MVVMService())
        let source = LoginViewModel.Source(viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()), loginAction: btnLogin.rx.tap.asDriver(), email: tfUserName.rx.text.orEmpty.asDriver(), password: tfPassword.rx.text.orEmpty.asDriver())
        let sink = (viewModel as! LoginViewModel).transform(source: source)
        self.bindData(sink)
    }
    
   //demo
    override func localizable() {
        tfPassword.placeholder = L10n.tr("login.password")
        tfUserName.placeholder = L10n.tr("login.email")
        btnLogin.setTitle(L10n.tr("login.login"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //createGradientLayer()
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        if let sink = sink as? LoginViewModel.Sink {
            sink.loginResponse.asObservable()
                .subscribe(onNext: {[weak self] loginModel in
                    // iOS13 or later
                    if #available(iOS 13.0, *) {
                        let sceneDelegate = UIApplication.shared.connectedScenes
                            .first!.delegate as! SceneDelegate
                        sceneDelegate.window!.rootViewController = R.storyboard.main.instantiateInitialViewController()
                    } else {
                        // UIApplication.shared.keyWindow?.rootViewController
                        UIApplication.shared.keyWindow?.rootViewController = R.storyboard.main.instantiateInitialViewController()
                    }
                }).disposed(by: disposeBag)
            
            sink.validation
                .asObservable()
                .subscribe(onNext: {[weak self] (isValid, message) in
                    if isValid == false {
                        self?.showMessage(message: message, closeAction: {})
                    }
                }).disposed(by: disposeBag)
            
            self.btnLogin.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.view.endEditing(true)
                }).disposed(by: disposeBag)
        }
    }

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
}

