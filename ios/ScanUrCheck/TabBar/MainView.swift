//
//  MainView.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var receipts: [ReceiptDTO] = []
    
    func fetchReceipts() {
        
    }
    
    func mockReceipts() {
       //   self.receipts = []
        
        for index in 0...5 {
            self.receipts.append(generateRandomReceipt())
        }
        
        print(self.receipts.count)
    }
    
    func handleQr(_ code: String) {
        print("Hadled this code: \(code)")
    }
}

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State var presentCamera: Bool = false
    
    var body: some View {
        VStack {
                            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.receipts, id: \.transactionDetails.receiptId) { item in
                        ReceiptCell(receipt: item)
                    }
                }
            }
            .padding(.horizontal, 12)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.royalPurple)
        .overlay(alignment: .bottom, content: {
            Circle()
                .fill(Color.ultraViolet)
                .frame(width: 80, height: 80)
                .overlay(alignment: .center) {
                    Button {
                        presentCamera = true
                    } label: {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.mimiPink)
                    }
                }
                .padding(.bottom, 10)
        })
        .fullScreenCover(isPresented: $presentCamera, content: {
            CameraView { code in
                presentCamera = false
            }
        })
        .onAppear {
            //This is endpoind
           // viewModel.fetchReceipts()
            
            //Delete after added API
            viewModel.mockReceipts()
        }
    }
}

struct ReceiptCell: View {
    let receipt: ReceiptDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Shop: \(receipt.companyName)")
            
           //Text("Fiscal code\(receipt.fiscalCode)")
            
            Text("Address: \(receipt.address)")
            
           // Text("Registration Number \(receipt.registrationNumber)")
            
         //   Text("Items: \(receipt.items[0])")
              //  .frame(width: 200)
           // receipt
                
         //   receipt.items
            
            HStack {
                Text("Type: \(receipt.total.paymentMethod)")
                
                Spacer()
                
                Text("Total: \(receipt.total.amount.twoDecimalString)")
                    .padding(.trailing, 12)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.leading, 24)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.teaRose)
        )
    }
}

#Preview {
    MainView()
}
