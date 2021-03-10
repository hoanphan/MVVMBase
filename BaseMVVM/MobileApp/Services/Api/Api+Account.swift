//
//  Api.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Moya

enum AccountTargetType {
    case signIn(username: String, password: String)
}

extension AccountTargetType: MVVMTargetType {

    var path: String {
        switch self {
        case .signIn:
            return Constants.accountLogin
        default:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        default:
            return .get
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var parameters: [String : Any]? {
        switch self {
        case .signIn(let username, let password):
            var paramester: [String: Any]? {
                var parameter:[String:Any] = [:]
                parameter["email"] = username
                parameter["password"] = password
                return parameter
            }
            return paramester
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .signIn:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}
