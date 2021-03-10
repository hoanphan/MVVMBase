//
//  CommonAlertView.swift
//  BaseMVVM
//
//  Created by HoanPV on 10/03/2021.
//

import Foundation
import UIKit
import RxSwift

class CommonAlertView: UIViewController {

    var message: String = ""
    var closeText: String = ""

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okButton: UIButton!
    let onOK: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.messageLabel.text = self.message
        }
    }

    func setupView() {
//        alertView.layer.cornerRadius = 9
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.okButton.setTitle(closeText, for: .normal)
    }

    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y +=  50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y -= 50
        })
    }

    @IBAction func onDismiss(_ sender: Any) {
        onOK.onNext(true)
        self.dismiss(animated: true, completion: nil)
    }
}
