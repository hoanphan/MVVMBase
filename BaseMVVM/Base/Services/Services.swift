//
//  Services.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Foundation
import ObjectMapper
import RxSwift
import RxCocoa

class Service: ServiceProtocol {
    var sessionManager: TSAPIManager
    let disposeBag = DisposeBag()
    var scheduler: RxSwift.ImmediateSchedulerType

    public init(timeout: TimeInterval = TimeInterval(60), scheduler: RxSwift.ImmediateSchedulerType = MainScheduler.instance) {
        sessionManager = TSAPIManager(timeoutIntervalForRequest: timeout)
        self.scheduler = scheduler
    }

    func get<API>(_ api: API) -> Observable<String> where API: BaseTargetType {
        if !NetworkConnectivity.isConnectedToInternet {
           return Observable.error(ServiceError.netWorkError)
        }

        return self.sessionManager.request(api: api).flatMap { (response) -> Observable<String> in
            do {
                let jsonString = try response.mapString()
                return Observable.just(jsonString)
            } catch {
                return Observable.error(error)
            }
        }
    }

    func getItem<T, API>(_ type: T.Type, _ api: API) -> Observable<T> where T: ImmutableMappable, API: BaseTargetType {
        return self.get(api).map {Mapper<T>().map(JSONString: $0)!}
    }

    func getItems<T, API>(_ type: T.Type, _ api: API) -> Observable<[T]> where T: ImmutableMappable, API: BaseTargetType {
        return self.get(api).map {Mapper<T>().mapArray(JSONString: $0)!}
    }
}

public enum ServiceError: Error {
    case netWorkError
    case parseError
    case encryptError
    case cancel
    case error(code: String, message: String, json: String)
    case unauthorized
}
