//
//  OnboardingModel.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import Foundation
import NoughtyUI
import SwiftUI

struct OnboardingItem {
    var image: ImageResource
    var title: String
    var subtitle: String
}
 
let onboardingItems: [OnboardingItem] = [
    .init(image: .firstScreen, title: "Scan check and track expenses", subtitle: "Quickly scan receipts and automatically track your spending with ease."),
    
        .init(image: .secondScreen, title: "Your data is safe", subtitle: "Your data is secure, easily erasable, and exported anonymously for full privacy."),
]
