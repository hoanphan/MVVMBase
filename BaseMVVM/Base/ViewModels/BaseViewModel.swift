//
//  BaseViewModel.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

open class BaseViewModel{
    
    public let disposeBag = DisposeBag()
    public var service:ServiceProtocol
    
    public init(service:ServiceProtocol){
        self.service = service
    }
}

