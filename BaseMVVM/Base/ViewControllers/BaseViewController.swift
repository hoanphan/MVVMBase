//
//  BaseViewController.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

open class BaseViewController: UIViewController, CTViewController, SegueProtocol {

    //  Outlet for header title
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBAction func tapBackAction(_ sender: Any) {

    }

    open var state: ViewControllerState = .unknown
    var disableUserInteractionWhileFetching: Bool = true
    public var viewModel: BaseViewModel?
    public var sender: Any?
    public var nvActivityIndicator: NVActivityIndicatorView?
    public let disposeBag = DisposeBag()

    public func setSender(_ sender: Any?) {
        self.sender = sender
    }

    public func getSender() -> Any? {
        return self.sender
    }

    open func setupView () {

    }

    open func localizable () {

    }

    open func bindData(_ sink: SinkType) {

        sink.fetching?
            .drive(self.nvActivityIndicator!.rx.isAnimating)
            .disposed(by: disposeBag)
        sink.fetching?
            .asObservable()
            .subscribe(onNext: {[weak self] (isFetching) in
                if self?.disableUserInteractionWhileFetching == true {
                    if isFetching == true {
                        UIApplication.shared.beginIgnoringInteractionEvents()
                    } else {
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                }
            }).disposed(by: disposeBag)
        sink.error?
            .drive(self.rx.showError)
            .disposed(by: disposeBag)
    }

    open func executeError(error: Error) {
        if self.state != .viewDidDisappear {
            if error is ServiceError {
                let error = error as! ServiceError
                switch error {
                case let .error(code, message, _):
                    if code != "999" {
                        self.showMessage(message: message) {}
                    } else {
                        self.showMessage(message: L10n.somethingWrong.string) {}
                    }
                case .netWorkError:
                    self.showMessage(message: L10n.netWorkError.string) {}
                case .parseError:
                    self.showMessage(message: L10n.paseError.string) {}
                case .encryptError:
                    break
                case .cancel:
                    break
                case .unauthorized:
                    self.showMessage(message: L10n.tokenExpire.string, closeText: "Đăng nhập") {
                        // Handle authen expire
                    }
                }
            } else {
                if (error as NSError).code == NSURLErrorTimedOut
                    || (error as NSError).code == NSURLErrorCannotFindHost
                    || (error as NSError).code == NSURLErrorCannotConnectToHost {
                    self.showMessage(message: L10n.requestTimeOut.string) {}
                } else {
                    self.showMessage(message: L10n.somethingWrong.string) {}
                }
            }
        }
    }

    open func showMessage(message: String, closeText: String = "Đóng", closeAction: @escaping () -> Void) {
        if let commonAlert = R.storyboard.main.commonAlertView() {
            commonAlert.providesPresentationContextTransitionStyle = true
            commonAlert.definesPresentationContext = true
            commonAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            commonAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

            commonAlert.message = message
            commonAlert.closeText = closeText

            self.present(commonAlert, animated: true, completion: nil)
            commonAlert.onOK.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    closeAction()
                }).disposed(by: disposeBag)
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.state = .viewDidload
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        if headerTitle != nil {
            headerTitle.font = UIFont.systemFont(ofSize: 17)
        }

        // Do any additional setup after loading the view.
        let xAxis = self.view.center.x // or use (view.frame.size.width / 2)
        let yAxis = self.view.center.y // or use (view.frame.size.height / 2)
        let frame = CGRect(x: (xAxis - 45/2), y: (yAxis - 45/2), width: 45, height: 45)
        nvActivityIndicator = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: UIColor.gray, padding: 0)
        self.view.addSubview(nvActivityIndicator!)

        self.setupView()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.state = .viewWillAppear
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        self.localizable()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        self.state = .viewDidDisappear
        super.viewDidDisappear(animated)
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseViewController {
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SegueProtocol {
            viewController.setSender(sender)
        }
    }
}

extension BaseViewController {
    func setHeaderTitle(_ title: String) {
        headerTitle.text = title
    }
}

public protocol SegueProtocol {
    func setSender(_ sender: Any?)
    func getSender() -> Any?
}

public enum ViewControllerState: Int, Equatable {
    case unknown = 0
    case viewDidload = 1
    case viewWillAppear = 2
    case viewDidDisappear  = 3

    public static func == (lhs: ViewControllerState, rhs: ViewControllerState) -> Bool {
            return lhs.rawValue == rhs.rawValue
    }
}
