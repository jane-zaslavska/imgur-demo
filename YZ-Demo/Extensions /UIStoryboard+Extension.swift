//
//  UIStoryboard+Extension.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 09.02.2022.
//

import Foundation
import UIKit

extension UIStoryboard {
    private struct Constants {
        static let kMain = "Main"
    }
    
    class var main: UIStoryboard {
        return UIStoryboard(name: Constants.kMain, bundle: nil)
    }
}
