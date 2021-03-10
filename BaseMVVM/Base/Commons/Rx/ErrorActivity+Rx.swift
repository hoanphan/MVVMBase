//
//  ErrorActivity+Rx.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: BaseViewController {

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var showError: Binder<Error> {
        return Binder(self.base) { viewController, error in
            viewController.executeError(error:error)

        }
    }

}
