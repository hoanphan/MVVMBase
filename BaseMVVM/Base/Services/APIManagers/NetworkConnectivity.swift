//
//  NetworkConnectivity.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Foundation
import Alamofire

open class NetworkConnectivity {
    public class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
