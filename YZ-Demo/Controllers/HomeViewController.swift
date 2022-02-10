//
//  HomeViewController.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties

    let viewModel = ImagesViewModel(client: ImgurClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = HomePreviewLayout()
        collectionView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil),
                                forCellWithReuseIdentifier: String(describing: ImageCell.self))

        viewModel.showLoading = { [weak self] in
            guard let self = self else { return }
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }

        viewModel.showError = { error in
            print(error)
        }

        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }

        viewModel.fetchPics()
    }
    
    func showDetails(for indexPath: IndexPath) {
        let sb = UIStoryboard.main
        let id = String(describing: DetailsViewController.self)
        guard let vc = sb.instantiateViewController(identifier: id) as? DetailsViewController else {
            return
        }
        vc.viewModel = viewModel.imageDetailsViewModel(for: indexPath)
        present(vc, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = String(describing: ImageCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! ImageCell
        let url = viewModel.cellViewModels[indexPath.item].url
        cell.configure(with: url)
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(for: indexPath)
    }
}
