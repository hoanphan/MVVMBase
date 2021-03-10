//
//  ServiceProtocol.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import RxSwift
import ObjectMapper

public protocol ServiceProtocol {
    func get<API: BaseTargetType>(_ api:API)-> Observable<String>
    func getItem<T:ImmutableMappable, API:BaseTargetType>(_ type:T.Type, _ api:API) -> Observable<T>
    func getItems<T:ImmutableMappable, API:BaseTargetType>(_ type:T.Type, _ api:API) -> Observable<[T]>
}
