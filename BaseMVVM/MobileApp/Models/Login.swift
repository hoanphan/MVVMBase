//
//  Login.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import ObjectMapper

public struct LoginModel: BaseModel {
    public var identifier: String = ""
    public let token: String?
    public let expire: String?
    public let email: String?
    
    init(identifier:String, token: String,  expire: String, email: String?) {
        self.identifier = identifier
        self.token = token
        self.expire = expire
        self.email = email
    }
}

extension LoginModel: ImmutableMappable {
    public init(map: Map) throws {
        self.token = try? map.value("token")
        self.expire = try? map.value("expire")
        self.email = try? map.value("email")
    }
}
