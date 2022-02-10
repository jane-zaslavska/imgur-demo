//
//  UIImageView+Extension.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 10.02.2022.
//

import Foundation
import UIKit

private let placeholder = UIImage(named: "placeholder")

extension UIImageView {
    
    static var imageCache = NSCache<NSString, UIImage>()
        
    static func initCache(with limit: Int) {
        imageCache.countLimit = limit
    }
    
    func load(from URLString: String) {
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = UIImageView.imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url,
                          completionHandler: { [weak self] (data, response, unsafeError) in
                guard let self = self else { return }
                if let error = unsafeError {
                    print("error loading images: \(error)")
                    DispatchQueue.main.async { self.image = placeholder }
                    return
                }
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    if let downloadedImage = UIImage(data: data) {
                        UIImageView.imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}
