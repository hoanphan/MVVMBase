/*
 Strings.swift
 HTCMobileApp
 
 Created by Tuan Pham Hai  on 10/19/18.
 Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
 */

import Foundation

enum L10n {
    //Network
    case somethingWrong
    case netWorkError
    case paseError
    case tokenExpire
    case requestTimeOut
    // Alert
    case alertTitle
    case alertClose
}

extension L10n: CustomStringConvertible {
    var description: String { return self.string }
    
    var string: String {
        switch self {
        //Network
        case .somethingWrong:
            return L10n.tr("some-thing-wrong")
        case .netWorkError:
            return L10n.tr("network-error")
        case .tokenExpire:
            return L10n.tr("token-expire")
        case .requestTimeOut:
            return L10n.tr("request-time-out")
        case .paseError:
            return L10n.tr("parse-error")
        //  Home
        case .alertTitle:
            return L10n.tr("home.title")
        case .alertClose:
            return L10n.tr("test")
        }
    }
    
    static func tr(_ key: String, _ args: CVarArg...) -> String {
        //  TODO: Load current setting language code: en, vi
        let languageCode = "vi"
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let format = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return String(format: format!, arguments: args)
    }
}

func tr(_ key: L10n) -> String {
    return key.string
}
