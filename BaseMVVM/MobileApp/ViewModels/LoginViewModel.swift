//
//  UserPrefsHelper.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import RxCocoa
import RxSwift

public class LoginViewModel: BaseViewModel {
    public func transform(source: LoginViewModel.Source) -> LoginViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let combineInfor = Driver.combineLatest(source.email, source.password)

        let validationEmail = source.loginAction
            .withLatestFrom(source.email)
            .flatMap { (email) -> Driver<(Bool, String)> in
                if email.isEmpty {
                    return Driver.just((false, L10n.tr("login.email-not-empty")))
                }

                if !isValidEmail(email) {
                    return Driver.just((false,  L10n.tr("login.email-not-correct-format")))
                }

                return Driver.just((true, ""))
        }

        let validationPassword = source.loginAction
            .withLatestFrom(source.password)
            .flatMap { (password) -> Driver<(Bool, String)> in
                if password.isEmpty {
                    return Driver.just((false, L10n.tr("login.password-not-empty")))
                }

                return Driver.just((true, ""))
        }

        let validation = source.loginAction
            .withLatestFrom(Driver.combineLatest(validationEmail, validationPassword))
            .flatMap { (validationEmail, validationPassword) -> Driver<Bool> in
                return Driver.just(validationPassword.0 && validationEmail.0)
        }

        let loginInputs = Driver.combineLatest(validation, combineInfor)
        let loginResponse = source.loginAction
            .withLatestFrom(loginInputs)
            .filter {$0.0 == true}
            .flatMap({ (args) -> Driver<LoginModel> in
                let (_, combineInfor) = args
                return self.service.getItem(LoginModel.self, AccountTargetType.signIn(username: combineInfor.0, password: combineInfor.1))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })

        return Sink(loginResponse: loginResponse,
                    validationEmail: validationEmail,
                    validationPassword: validationPassword,
                    fetching: activityIndicator.asDriver(),
                    error: errorTracker.asDriver())
    }

}

extension LoginViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let loginAction: Driver<Void>
        public let email: Driver<String>
        public let password: Driver<String>

        public init(viewWillAppear:Driver<Void>,
                    loginAction: Driver<Void>,
                    email: Driver<String>,
                    password: Driver<String>) {
            self.viewWillAppear = viewWillAppear
            self.loginAction = loginAction
            self.email = email
            self.password = password
        }
    }

    public struct Sink: SinkType {
        public var loginResponse: Driver<LoginModel>
        public var validationEmail: Driver<(Bool, String)>
        public var validationPassword: Driver<(Bool, String)>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
