//
//  PromotionsAndBanners.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import SwiftUI
import NoughtyUI

struct PromotionsAndBanners: View {
    var body: some View {
        VStack {
            Circle()
                .fill(.white)
                .frame(width: 100, height: 100)
                .overlay(alignment: .center) {
                    VStack {
                        Text("100")
                        
                        Text("Coins earned")
                            .font(.system(size: 10))
                    }
                }
                .shadow(color: Color(hex: "#EDD2E0"), radius: 5)
                .padding(.top, 15)
            
            Text("Promotions")
                .font(.system(size: 16))
                .foregroundStyle(Color(hex: "#6A788E"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                
                Image(.firstBanner)
                    .frame(width: 81, height: 94)
                                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Papermax Promotion \n\"BACK TO SCHOOL")
                        .font(.system(size: 16))
                    
                    Text("MySkin 20% Discount END OF SEASON SALE")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#808080"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
            
            HStack(spacing: 8) {
                
                Image(.secondBanner)
                    .frame(width: 81, height: 94)
                                
                VStack(alignment: .leading, spacing: 8) {
                    Text("MySkin  20% Discount \nEND OF SEASON SALE")
                        .font(.system(size: 16))
                    
                    Text("Valid date: 40.10.2024 Coins needed: 105")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#808080"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
            

            
        }
        .navigationTitle("Offers & Promotions")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    PromotionsAndBanners()
}
