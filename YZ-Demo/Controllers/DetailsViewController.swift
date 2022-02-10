//
//  DetailsViewController.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties

    var viewModel: ImageDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configure() {
        guard let viewModel = viewModel else {
            return
        }
        imageView.load(from: viewModel.link)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    func animation() {
        let offset = CGPoint(x: -view.frame.maxX, y: 0)
        let x: CGFloat = 0, y: CGFloat = 0
        titleLabel.transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        titleLabel.isHidden = false
        UIView.animate(
            withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.47, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                self.titleLabel.transform = .identity
                self.titleLabel.alpha = 1
        }, completion: {  [weak self] _ in
            guard let self = self else { return }
            self.descriptionLabel.transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
            self.descriptionLabel.isHidden = false
            UIView.animate(
                withDuration: 1, delay: 0, usingSpringWithDamping: 0.47, initialSpringVelocity: 3,
                options: .curveEaseOut, animations: {
                    self.descriptionLabel.transform = .identity
                    self.descriptionLabel.alpha = 1
                })
        })
    }
}
