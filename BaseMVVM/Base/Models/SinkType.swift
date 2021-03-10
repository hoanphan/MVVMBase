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
    var fetching: Driver<Bool>? {get set}
    var error: Driver<Error>? {get set}
}

public protocol ListSinkType: SinkType {
    var itemsSource: Driver<[Any]>? {get set}
    var refresh: Driver<Bool>? {get set}
}
