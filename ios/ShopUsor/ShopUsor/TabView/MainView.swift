//
//  MainView.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI
import API
import NoughtyUI

final class MainViewModel: ObservableObject {
    @Published var receipts: [ReceiptDTO] = []
    @Published var showErrorPopup = false
    @Published var errorMessage = ""
    @Published var lastScannedCode = ""
    @Published var isLoading = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" // Устанавливаем нужный формат даты
        return formatter
    }()
    
    var groupedReceipts: [String: [ReceiptDTO]] {
        Dictionary(grouping: receipts) { receipt in
            return dateFormatter.string(from: receipt.transactionDetails.purchasedAt ?? .init())
        }
    }
    
    // Сортировка дат для отображения
    var sortedKeys: [String] {
        return groupedReceipts.keys.sorted { dateString1, dateString2 in
            guard let date1 = dateFormatter.date(from: dateString1),
                  let date2 = dateFormatter.date(from: dateString2) else {
                return false
            }
            return date1 > date2
        }
    }
    
    func fetchReceipts() {
        isLoading = true
        Task {
            do {
                let result = try await DefaultAPI.getAllReceipts(page: 1, limit: 10).data ?? []
                await MainActor.run {
                    isLoading = false
                    self.receipts = result
                }
                print(receipts.count)
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func findItem(item: String) {
        if item.isEmpty {
            fetchReceipts()
        } else {
            receipts = receipts.filter({ $0.items.contains(where: { $0.description.lowercased().contains(item.lowercased())})})
        }
    }
    
    func filterByPrice() {
        receipts.sort(by: { $0.totalAmount > $1.totalAmount })
    }
    
    func saveReceipt(receiptUrl: String) {
        isLoading = true
        Task {
            do {
                let response = try await DefaultAPI.createReceipt(receiptUrlDTO: .init(url: receiptUrl))
                print(response)
                if let error = response.error {
                    await MainActor.run {
                        self.showErrorPopup = true
                        self.errorMessage = error
                    }
                } else {
                    await MainActor.run {
                        self.isLoading = false
                        self.receipts.append(response.data!)
                        self.fetchReceipts()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func handleQr(_ code: String) {
        print("Hadled this code: \(code)")
    }
}

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var presentCamera: Bool = false
    @State var text: String = ""
    
    var body: some View {
        VStack {
            //header
            HStack {
                NavigationLink {
                    PieChartExampleView()
                } label: {
                    Image(systemName: "chart.bar")
                        .resizable()
                        .frame(width: 19, height: 17)
                        .foregroundStyle(.black)
                        .padding(6)
                        .background(Color(hex: "#EDD2E0"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                .clipped()
                
                Spacer()
                
                Text("ShopUsor")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(hex: "#062C4B"))
                
                Spacer()
                
                HStack {
                    
                    NavigationLink {
                        SettingsScreen()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 19, height: 17)
                            .foregroundStyle(.black)
                            .padding(6)
                            .background(Color(hex: "#EDD2E0"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    .clipped()
                    
                    NavigationLink {
                        PromotionsAndBanners()
                    } label: {
                        Image(systemName: "percent")
                            .resizable()
                            .frame(width: 19, height: 17)
                            .foregroundStyle(.black)
                            .padding(6)
                            .background(Color(hex: "#EDD2E0"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    .clipped()
                    
                }
            }
            
            MessageComposerView(text: $text) {
                viewModel.findItem(item: text)
            }
            .padding(.top, 20)
            
            Button {
                viewModel.filterByPrice()
            } label: {
                HStack {
                    Image(.filter)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.black)
                    
                    Text("Filter")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                
            }
            .padding(.top, 13 )
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.sortedKeys, id: \.self) { date in
                        Section {
                            ForEach(viewModel.groupedReceipts[date] ?? [], id: \.receiptId) { receipt in
                                NavigationLink {
                                    RecieptView(receipt: receipt)
                                } label: {
                                    ReceiptCell(receipt: receipt)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
                                        .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
                                }
                            }
                        } header: {
                            Text(date)
                                .bold()
                                .foregroundStyle(.black)
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding(.horizontal, 1)
            }
            .scrollIndicators(.hidden)
            .padding(.top, 20)
            
            
            Button {
                presentCamera = true
            } label : {
                Text("+")
                    .font(.system(size: 30))
                    .fontWeight(.light)
                    .foregroundStyle(Color(hex: "#63458A"))
                    .padding(20)
            }
            .background {
                Circle()
                    .fill(Color(hex: "#EDD2E0"))
                    .blur(radius: 3)
                    .shadow(color: Color(hex: "#9A48D09").opacity(0.3), radius: 10)
            }
            .containerShape(Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 24)
        .background(.white)
        .fullScreenCover(isPresented: $presentCamera, content: {
            CameraView { code in
                presentCamera = false
                viewModel.lastScannedCode = code
                viewModel.saveReceipt(receiptUrl: code)
            }
        })
        .onAppear {
            viewModel.fetchReceipts()
        }
        .overlay(alignment: .bottomLeading, content: {
           // ZStack {
            NavigationLink {
                OwlChat()
            } label: {
                Image(.owl)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .overlay {
                        Image(.owlCloud)
                            .resizable()
                            .frame(width: 69, height: 51)
                            .padding(.leading, 110)
                            .padding(.bottom, 60)
                    }
                    .padding(.leading, 25)
            }
        })
        .overlay(alignment: .center, content: {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 40, height: 40)
                    .background {
                        Circle()
                            .fill(.white)
                            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
                            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
                    }
            }
        })
        .overlay {
            if viewModel.showErrorPopup {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(maxWidth: 300, maxHeight: 200)
                    .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
                    .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
                    .overlay {
                        VStack {
                            Text(viewModel.errorMessage)
                                .foregroundStyle(.black)
                                .font(.title)
                            
                            Button {
                                viewModel.showErrorPopup = false
                               // viewModel.showErrorPopup = false
                               // RecieptView(receipt: viewModel.receipts.first(where: { $0.receiptId.contains(viewModel.lastScannedCode)})!)
                            } label: {
                                Text("OK")
                                    .foregroundStyle(Color(hex: "#9A48D0"))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(hex: "#EDD2E0"))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
            }
            
        }
        .onDisappear(perform: {
            viewModel.showErrorPopup = false
        })
    }
}

struct ReceiptCell: View {
    let receipt: ReceiptDTO
    
    var body: some View {
        HStack(spacing: 10) {
            Text(receipt.companyName)
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(receipt.totalAmount.formattedToTwoDecimals())
                .foregroundStyle(.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        
        
    }
}

#Preview {
    MainView()
}
