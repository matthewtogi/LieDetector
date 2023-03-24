//
//  LottieButton.swift
//  LieDetector
//
//  Created by Matthew Togi on 23/03/23.
//

import SwiftUI
import Lottie


struct LottieButton: UIViewRepresentable{
    typealias UIViewType = UIView

    var animationName: String
    let animationButton = AnimatedButton()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animation = LottieAnimation.named(animationName)

        animationButton.animation = animation
        animationButton.contentMode = .scaleAspectFit
        animationButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchUpInside)

        animationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview (animationButton)

        NSLayoutConstraint.activate([
            animationButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationButton.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationButton.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            animationButton.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])

        return view
    }
    func updateUIView(_ uiView: UIView, context: Context){}
}
