//
//  GifsViewModel.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import Foundation
import UIKit

struct CellViewModel {
    let url: String
}

class ImagesViewModel {
    
    private let client: APIClient
    private var images: Images = [] {
        didSet {
            mapModels()
        }
    }
    var cellViewModels: [CellViewModel] = []
    
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    init(client: APIClient) {
        self.client = client
    }
    
    func fetchPics() {
        if let client = client as? ImgurClient {
            isLoading = true
            let endpoint = ImgurEndpoint.pics
            do {
                try client.fetch(with: endpoint) { [weak self] (either) in
                    guard let self = self else { return }
                    switch either {
                    case .success(let data):
                        self.images = data.data
                    case .error(let error):
                        self.showError?(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func mapModels() {
        cellViewModels = images.map { CellViewModel(url: $0.link) }
        isLoading = false
        reloadData?()
    }
    
    func imageDetailsViewModel(for indexPath: IndexPath) -> ImageDetailsViewModel {
        let image = images[indexPath.row]
        let model = ImageDetailsViewModel(link: image.link,
                                          title: image.title,
                                          description: image.description,
                                          score: "\(image.score)")
        return model
    }
}
