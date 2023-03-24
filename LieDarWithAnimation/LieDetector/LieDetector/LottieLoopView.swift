//
//  LottieView.swift
//  LieDetector
//
//  Created by Matthew Togi on 23/03/23.
//

import Lottie
import SwiftUI

struct LottieLoopView: UIViewRepresentable{
    typealias UIViewType = UIView
    var animationName: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)])

        return view
    }
    func updateUIView(_ uiView: UIView, context: Context){}
}

