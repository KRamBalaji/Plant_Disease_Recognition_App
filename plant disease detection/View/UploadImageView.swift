//
//  UploadImageView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 02/09/22.
//

import SwiftUI

struct UploadImageView: View {
    
    @State var firstRun = true
    let imagePredictor = ImagePredictor()
    let predictionsToShow = 2
    @State var startupPrompts: UIStackView?
    @State var predictionLabel: String?
    
    @State var image: UIImage = (UIImage(named: "newphoto")!)
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        var id: Int {
            hashValue
        }
    }
    
    @State private var photoSource: PhotoSource?
    
    var body: some View {
        VStack{
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            VStack {
                Button(action: {self.photoSource = .camera}) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Click with camera")
                            .font(.headline)
                    }
                    .frame(width: 185)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.black))
                    .shadow(color: .gray, radius: 2, x: -3, y: 5)
                }
                Button(action: {self.photoSource = .photoLibrary}) {
                    HStack {
                        Image(systemName: "photo.stack")
                        Text("Select photo")
                            .font(.headline)
                    }
                    .frame(width: 185)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.black))
                    .shadow(color: .gray, radius: 2, x: -3, y: 5)
                }
                Button(action: {
                        classifyImage(image)
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Predict")
                            .font(.headline)
                    }
                    .frame(width: 185)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.black))
                    .shadow(color: .gray, radius: 2, x: -3, y: 5)
                }
            }
            .padding(.vertical)
            Text(predictionLabel ?? "Prediction goes here")
                .font(.system(size: 28))
                .bold()
            Spacer()
        }
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $image).ignoresSafeArea()
            case .camera: ImagePicker(sourceType: .camera, selectedImage: $image).ignoresSafeArea()
            }
        }
    }
    
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image, completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
    }
    
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel = message
            print(message)
        }

        if firstRun {
            DispatchQueue.main.async {
                self.firstRun = false
                self.startupPrompts?.isHidden = true
            }
        }
    }
    
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}
