//
//  AnimationTestView.swift
//  LieDetector
//
//  Created by Matthew Togi on 23/03/23.
//

import SwiftUI

struct AnimationTestView: View {
    var body: some View {
        LottieLoopView(animationName: "Truth Screen")
    
    }
    
    struct AnimationTestView_Previews: PreviewProvider {
        static var previews: some View {
            AnimationTestView()
        }
    }
}
