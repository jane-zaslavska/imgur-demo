//
//  CGRect+Extension.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 10.02.2022.
//

import Foundation
import UIKit

struct InterItem {
    var vertical: CGFloat = 0.0
    var horizontal: CGFloat = 0.0
}

extension CGRect {
    func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge, with
                            insets: InterItem = InterItem()) -> (first: CGRect, second: CGRect) {
        let dimension: CGFloat
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = self.size.width - insets.horizontal
        case .minYEdge, .maxYEdge:
            dimension = self.size.height - insets.vertical
        }
        
        let distance = (dimension * fraction)
        var slices = self.divided(atDistance: distance, from: fromEdge)
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            slices.remainder.origin.x += insets.horizontal
            slices.remainder.size.width -= insets.horizontal
        case .minYEdge, .maxYEdge:
            slices.remainder.origin.y += insets.vertical
            slices.remainder.size.height -= insets.vertical
        }
        
        return (first: slices.slice, second: slices.remainder)
    }
    
    func sliceEqually(count: Int, from fromEdge: CGRectEdge,
                      with insets: InterItem = InterItem()) -> [CGRect] {
        
        let dimension: CGFloat
        var slices = [CGRect]()
        var currFrame = self
        
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = self.size.width - insets.horizontal * CGFloat(count - 1)
        case .minYEdge, .maxYEdge:
            dimension = self.size.height - insets.vertical * CGFloat(count - 1)
        }
        
        let distance = (dimension / CGFloat(count))
        
        for _ in 0..<count {
            var currSlices = currFrame.divided(atDistance: distance, from: fromEdge)
            slices.append(currSlices.slice)
            
            switch fromEdge {
            case .minXEdge, .maxXEdge:
                currSlices.remainder.origin.x += insets.horizontal
                currSlices.remainder.size.width -= insets.horizontal
            case .minYEdge, .maxYEdge:
                currSlices.remainder.origin.y += insets.vertical
                currSlices.remainder.size.height -= insets.vertical
            }
            
            currFrame = currSlices.remainder
        }
        
        return slices
    }
    
}
