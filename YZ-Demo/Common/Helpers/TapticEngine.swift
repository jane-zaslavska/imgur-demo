//
//  TapHelper.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import Foundation
import AVFoundation
import AudioToolbox
import UIKit

enum Vibration: Int {
    case light
    case medium
    case heavy
}

final class TapticEngine {
    static let vibration = TapticEngine()
    
    func vibrate(effect: Vibration) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: effect.rawValue)!)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
}
