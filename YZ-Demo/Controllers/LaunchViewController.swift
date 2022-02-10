//
//  LaunchViewController.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        make(view: stackView, visible: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIntro { [weak self] in
            guard let self = self else { return }
            self.alternateOutro {
                self.presentHome()
            }
        }
    }

    func presentHome() {
        let id = String(describing: HomeViewController.self)
        let homeVC = UIStoryboard.main.instantiateViewController(identifier: id)
        present(homeVC, animated: false, completion: nil)
    }
    
    func animateIntro(completion: (()->())? = nil) {
        TapticEngine.vibration.vibrate(effect: .medium)
        let multiplier: CGFloat = 2.0
        searchLabel.frame.origin.y -= searchLabel.frame.height * multiplier
        titleLabel.frame.origin.y -= titleLabel.frame.height * multiplier
        imageView.frame.origin.y -= imageView.frame.height * multiplier
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.searchLabel.frame.origin.y += self.searchLabel.frame.height * multiplier
            self.titleLabel.frame.origin.y += self.titleLabel.frame.height * multiplier
            self.imageView.frame.origin.y += self.imageView.frame.height * multiplier
            self.make(view: self.stackView, visible: true)
        } completion: { (_) in
            TapticEngine.vibration.vibrate(effect: .light)
            completion?()
        }
    }
    
    func alternateOutro(completion: (()->())? = nil) {
        TapticEngine.vibration.vibrate(effect: .light)
        let newOriginY: CGFloat = calculateNeededOriginY()
        let spacer: CGFloat = 10
        animate(view: searchLabel, distance: newOriginY, duration: 1.1)
        animate(view: titleLabel,  distance: newOriginY - spacer, duration: 1.3)
        animate(view: imageView,   distance: newOriginY - spacer * 2, duration: 1.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            TapticEngine.vibration.vibrate(effect: .light)
            completion?()
        }
    }
    
    private func make(view: UIView, visible: Bool) {
        view.alpha = visible ? 1.0 : 0.0
    }
    
    private func calculateNeededOriginY() -> CGFloat {
        let viewSafeInset = view.safeAreaInsets.top
        let stackViewOrigin = stackView.frame.origin.y
        let needeedDistance = stackViewOrigin - viewSafeInset - 40
        return needeedDistance
    }
    
    private func animate(view: UIView, distance: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut) {
            view.frame.origin.y -= distance
        }
    }
}
