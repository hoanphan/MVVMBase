//
//  CTViewController.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//
import Foundation

public protocol CTViewController: class {
    func bindData(_ sink: SinkType)
}
