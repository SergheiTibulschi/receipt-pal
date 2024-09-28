//
//  OnboardingStyle.swift
//  TipSocial
//
//  Created by Dmitrii Sorochin on 20.09.2024.
//

import Foundation
import NoughtyUI
import SwiftUI

struct OnboardingStyle: OnboardingViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            
            configuration.label
            
            Spacer()
            
            HStack {
                ForEach(0..<configuration.screensCount) { currentStep in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(currentStep == configuration.currentStep ? Color(hex: "#689CC8") : Color(hex: "#D9D9D9"))
                        .frame(width: currentStep == configuration.currentStep ? 20 : 10, height: 10)
                        .animation(.easeInOut, value: configuration.currentStep)
                }
            }
            .padding(.bottom, 58)
            
            Button {
                if configuration.currentStep < configuration.screensCount - 1 {
                    configuration.currentStep += 1
                } else {
                    configuration.onEndAction()
                }
            } label: {
                Text(configuration.currentStep != configuration.screensCount - 1  ? "Next" : "Let's Start")
                    .font(.system(size: 16))
                    .frame(width: 160, height: 56)
                    .background(configuration.currentStep != configuration.screensCount - 1 ? Color(hex: "#EDD2E0") : Color(hex: "#9A48D0"))
                    .foregroundStyle(configuration.currentStep != configuration.screensCount - 1 ? Color(hex: "#9A48D0") : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .bold()
            }
            .padding(.bottom, 60)
        }
        .padding(.horizontal, 27)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
    }
}

#Preview {
    OnboardingPage(onEndAction: {})
}
