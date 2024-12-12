//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
