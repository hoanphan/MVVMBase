//
//  BaseResponse.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import ObjectMapper

public struct BaseResponse: BaseModel {
    public var identifier: String = ""

    public let code: String?
    public let message: String?

    public init(code: String,
                message: String) {
        self.code = code
        self.message = message

    }

    public func getCode() -> String {
        return code ?? ""
    }

    public func getMessage() -> String {
        return message ?? ""
    }
}

extension BaseResponse: ImmutableMappable {
    public init(map: Map) throws {
        code = try? map.value("code")
        message = try? map.value("message")
    }
}
