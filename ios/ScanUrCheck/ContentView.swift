//import Foundation
//import UIKit
//import SwiftUI
//
//struct CameraView: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//    
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: CameraView
//        
//        init(parent: CameraView) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            parent.presentationMode.wrappedValue.dismiss()
//            
//            if let image = info[.editedImage] as? UIImage {
//                parent.selectedImage = image
//            }
//        }
////        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .camera
//        picker.allowsEditing = true
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
//
//struct ContentView: View {
//    @State private var selectedImage: UIImage?
//    @State private var isPresentingCamera = false
//    
//    var body: some View {
//        VStack(spacing: 50) {
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//            } else {
//                Text("No image selected")
//            }
//            
//            Button {
//                isPresentingCamera = true
//            } label: {
//                Text("Open Camera")
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 50)
//                    .padding(.vertical, 6)
//                    .background(.green)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
//            .sheet(isPresented: $isPresentingCamera) {
//                CameraView(selectedImage: $selectedImage)
//            }
//        }
//    }
//}
//
//
//
//
//#Preview {
//   // ContentView()
//    EmptyView()
//}
////