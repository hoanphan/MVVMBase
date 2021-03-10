//
//  BaseModel.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
public protocol BaseModel {
    var identifier: String {get set}
}

extension BaseModel {
    public func withIdentifier(_ identifier: String) -> Self {
        var value = self
        value.identifier = identifier
        return value
    }
}
