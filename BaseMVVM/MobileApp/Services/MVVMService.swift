//
//  MVVMService.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import ObjectMapper
import RxSwift
import Moya

class MVVMService: Service {
    override init(timeout: TimeInterval = TimeInterval(60), scheduler: RxSwift.ImmediateSchedulerType = MainScheduler.instance) {
        super.init(timeout: timeout, scheduler: scheduler)
    }

    override func get<API>(_ api: API) -> Observable<String> where API : BaseTargetType {
        if(!NetworkConnectivity.isConnectedToInternet) {
           return Observable.error(ServiceError.netWorkError)
        }

        return self.sessionManager.request(api: api).flatMap { (response) -> Observable<String> in
            if response.statusCode == 401 || response.statusCode == 403 {
                return Observable.error(ServiceError.unauthorized)
            }

            do {
                let jsonString = try response.mapString()
                return Observable.just(jsonString)
            } catch {
                return Observable.error(error)
            }
        }
    }

    override func getItem<T, API>(_ type: T.Type, _ api: API) -> Observable<T> where T : ImmutableMappable, API : BaseTargetType {
        return self.get(api)
            .observe(on: self.scheduler)
            .flatMap { json -> Observable<ItemResponse<T>> in
                if(json.isEmpty) {
                    return Observable.error(ServiceError.error(code: "999",message: "Error", json: json))
                }
                print(json)

                let response = try? Mapper<ItemResponse<T>>().map(JSONString: json)
                if(response == nil) {
                    return Observable.error(ServiceError.parseError)
                }

                if(response!.getCode() != "200") {
                    return Observable.error(ServiceError.error(code: response!.getCode(),message: response!.getMessage() , json: json))
                }

                return Observable.just(response!)
            }
            .filter {$0.data != nil}
            .map {$0.data!}
    }

    override func getItems<T, API>(_ type: T.Type, _ api: API) -> Observable<[T]> where T : ImmutableMappable, API : BaseTargetType {
        return self.get(api)
            .observe(on: self.scheduler)
            .flatMap { json -> Observable<ItemsResponse<T>> in

                if(json.isEmpty) {
                    return Observable.error(ServiceError.error(code: "999",message: "Error", json: json))
                }

                print("response: \(json)")

                let response = try? Mapper<ItemsResponse<T>>().map(JSONString: json)
                if(response == nil) {
                    return Observable.error(ServiceError.parseError)
                }

                if(response!.getCode() != "200") {
                    return Observable.error(ServiceError.error(code: response!.getCode(),message : response!.getMessage(),json: json))
                }

                return Observable.just(response!)

            }
            .filter {$0.data != nil}
            .map {$0.data!}
    }

}
