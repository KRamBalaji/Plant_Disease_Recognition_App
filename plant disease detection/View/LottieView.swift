//
//  LottieView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 15/11/22.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let lottieFile: String
 
    let animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
