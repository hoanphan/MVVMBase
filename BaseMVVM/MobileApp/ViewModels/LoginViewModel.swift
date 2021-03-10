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
        
        let validation = source.loginAction
            .withLatestFrom(combineInfor)
            .flatMap { (email, password) -> Driver<(Bool, String)> in
                var message = ""
                
                if email.isEmpty {
                    message = L10n.tr("login.email-not-empty")
                    return Driver.just((false, message))
                }
                
                if !isValidEmail(email) {
                    message = L10n.tr("login.email-not-correct-format")
                    return Driver.just((false, message))
                }
                
                if password.isEmpty {
                    message = L10n.tr("login.password-not-empty")
                    return Driver.just((false, message))
                }
                
                return Driver.just((true, message))
        }
       
        let loginInputs = Driver.combineLatest(validation, combineInfor)
        let loginResponse = source.loginAction
            .withLatestFrom(loginInputs)
            .filter{$0.0.0 == true}
            .flatMap({ (args) -> Driver<LoginModel> in
                let (_, combineInfor) = args
                return self.service.getItem(LoginModel.self, AccountTargetType.signIn(username: combineInfor.0, password: combineInfor.1))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        return Sink(loginResponse: loginResponse, validation: validation, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
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
        public var validation: Driver<(Bool, String)>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
