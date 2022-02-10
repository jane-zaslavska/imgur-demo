//
//  ImageCell.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 09.02.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "placeholder")
    }
    
    func configure(with url: String) {
        imageView.load(from: url)
        print(url)
    }

}
