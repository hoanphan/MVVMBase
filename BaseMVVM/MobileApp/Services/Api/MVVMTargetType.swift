//
//  MVVMTargetType.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit

protocol MVVMTargetType: BaseTargetType {

}

extension MVVMTargetType {
    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }

    var sampleData: Data {
        return Data()
    }
}
