//
//  SinkType.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import RxCocoa
import RxSwift

public protocol SinkType {
    var fetching: Driver<Bool>? {set get}
    var error: Driver<Error>? {set get}
}

public protocol ListSinkType : SinkType {
    var itemsSource : Driver<[Any]>? {set get}
    var refresh : Driver<Bool>? {set get}
}
