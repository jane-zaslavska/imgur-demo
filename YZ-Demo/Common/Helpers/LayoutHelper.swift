//
//  LayoutHelper.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 10.02.2022.
//

import Foundation
import UIKit

protocol LayoutHelperProtocol {
    func getSmallSegmentFrame(lastFrame: CGRect) -> CGRect
    func getBigSegmentFrame(lastFrame: CGRect) -> CGRect
}

class LayoutHelper: LayoutHelperProtocol {
    
    var collectionViewWidth: CGFloat = 0.0
    var insets: InterItem = InterItem()
    
    init(with collectionViewWidth: CGFloat, insets: InterItem = InterItem()) {
        self.collectionViewWidth = collectionViewWidth
        self.insets = insets
    }
    
    private func getBigSegmentHeight() -> CGFloat {
        let height = collectionViewWidth * 2 / 3
        return height
    }
    
    private func getSmallSegmentHeight() -> CGFloat {
        let height = collectionViewWidth / 3
        return height
    }
    
    func getSmallSegmentFrame(lastFrame: CGRect) -> CGRect {
        return CGRect(x: 0, y: lastFrame.maxY + insets.vertical,
                      width: collectionViewWidth,
                      height: getSmallSegmentHeight())
    }
    
    func getBigSegmentFrame(lastFrame: CGRect) -> CGRect {
        return CGRect(x: 0, y: lastFrame.maxY + insets.vertical,
                      width: collectionViewWidth,
                      height: getBigSegmentHeight())
    }
}
