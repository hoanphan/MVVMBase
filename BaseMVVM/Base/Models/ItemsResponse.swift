//
//  ItemsResponse.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Foundation
import ObjectMapper

public struct ItemsResponse<T:ImmutableMappable>  : BaseModel {
    public var identifier: String = ""

    public let code: Int?
    public let message: String?
    public var data: [T]?
    public let success: Bool?

    public init(code: Int,
                message: String,
                success: Bool,
                data: [T]) {
        self.code = code
        self.data = data
        self.message = message
        self.success = success
    }

    public func getCode() -> String {
        return "\(self.code ?? 0)"
    }

    public func getMessage() -> String {
        return self.message ?? ""
    }
}

extension ItemsResponse: ImmutableMappable {
    public init(map: Map) throws {
        code = try? map.value("code")
        message = try? map.value("message")
        data = try? map.value("data")
        success = try? map.value("success")
    }
}
