//
//  UIViewController+Rx.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    private func controlEvent(for selector: Selector) -> ControlEvent<Void> {
        return ControlEvent(events: sentMessage(selector).map { _ in })
    }

    /// Observable, triggered when the view has appeared for the first time
    public var firstTimeViewWillAppear: Single<Void> {
        return sentMessage(#selector(Base.viewWillAppear)).map { _ in
            return Void()
            }.take(1).asSingle()
    }

    public var viewWillAppear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewWillAppear))
    }

    /// Observable, triggered when the view has appeared for the first time
    public var firstTimeViewDidAppear: Single<Void> {
        return sentMessage(#selector(Base.viewDidAppear)).map { _ in
            return Void()
            }.take(1).asSingle()
    }

    public var viewDidAppear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewDidAppear))
    }

    public var viewWillDisappear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewWillDisappear))
    }

    public var viewDidDisappear: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewDidDisappear))
    }

    public var viewDidLoad: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.viewDidLoad))
    }

    public var didReceiveMemoryWarning: ControlEvent<Void> {
        return controlEvent(for: #selector(UIViewController.didReceiveMemoryWarning))
    }
}
