//
//  OnboardingViewItem.swift
//  TipSocial
//
//  Created by Dmitrii Sorochin on 20.09.2024.
//

import SwiftUI
import NoughtyUI

struct OnboardingViewItem: View {
    var item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 26) {
            
            Rectangle()
                .fill(.clear)
                .padding(.top, 38)
                .padding(.horizontal, 42)
                .frame(height: 300)
                .overlay {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                }
            
            Text(item.title)
                .font(.system(size: 32))
                .foregroundStyle(.black)
            
            Text(item.subtitle)
                .font(.system(size: 18))
                .foregroundStyle(Color(hex: "#8C8A8A"))
                .multilineTextAlignment(.center)
        }
    }
}

struct OnboardingPage: View {
    @State private var currentStep = 0
    var onEndAction: () -> ()
    
    var body: some View {
        OnboardingView(
            currentStep: $currentStep,
            screensCount: onboardingItems.count,
            onEndAction: { onEndAction() },
            content: { OnboardingViewItem(item: onboardingItems[currentStep]) }
        )
        .onboardingStyle(OnboardingStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeIn, value: currentStep)
    }
}

#Preview {
    OnboardingPage(onEndAction: {})
}
