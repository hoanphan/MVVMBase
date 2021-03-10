//
//  ViewModelType.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import Foundation

public protocol ViewModelType {
    associatedtype Source
    associatedtype Sink
    
    func transform(source: Source) -> Sink
}
