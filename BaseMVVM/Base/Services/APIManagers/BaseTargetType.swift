//
//  BaseTargetType.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Moya

public protocol BaseTargetType: TargetType {
    var parameters: [String: Any]? {get}
    var parameterEncoding: ParameterEncoding {get}
}

extension BaseTargetType {
    public var sampleData: Data {
        return Data()
    }

    public var task: Moya.Task {
        return .requestParameters(parameters: self.parameters!, encoding: parameterEncoding)
    }
}
