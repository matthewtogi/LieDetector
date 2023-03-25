//
//  TruthView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct TruthView: View {
    @State private var heartRate = Int.random(in: 70...130)
    @State private var isPressed = false
    @State private var isReleased = false
    @State private var randomCount = Int.random(in: 0...4)
    @State private var sentences = ["Yes, yes, yes! This person serve facts only.", "Facts are facts. What is true is true, and it does not need decoration, period!", "A trustworthy and a worthy friend. (worth more than 1000 of your fake friends). Yes you could tell them everything, include your darkest secret 🤭.", "There is beauty in truth, even if it's painful.", "20 % truth, 80% Super Truth 👍"]
    @Binding var speechToText: String
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1)
                
                LottieLoopView(animationName: "Confetti")
                
                VStack{
                    Text("This person is telling the")
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Text("TRUTH")
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                    
                    Text("😃")
                        .font(.system(size: 180))
                    
                    VStack{
                        Text("\"\(speechToText)\"")
                            .foregroundColor(Color(.white))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5)
                            .italic()
                        
                        Text("\(sentences[randomCount])")
                            .foregroundColor(Color(.white))
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(30)
                    .background(.white.opacity(0.2))
                    .frame(width: 350)
                    .cornerRadius(30)
                    .padding(.top, -100)
                    
                    HStack(spacing: 15){
                        Image("red-heart-icon")
                            .resizable()
                            .frame(width: 40, height: 37)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average Heartbeat")
                                .foregroundColor(.white)
                            Text("\(heartRate) BPM")
                                .foregroundColor(.white)
                                .font(.system(size: 32, weight: .bold))
                            
                        }
                    }.padding(20)
                    
                    NavigationLink(destination: ContentView()){
                        Text("Back to Home")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .frame(maxWidth: 300, maxHeight: 60)
                            .background(.white)
                            .cornerRadius(80)
                            .padding(.top, 20)
                            
                        
                    }
                    
                    
                }
            }
            
        } .navigationBarBackButtonHidden()
    }
}

struct TruthView_Previews: PreviewProvider {
    static var previews: some View {
        TruthView(speechToText: .constant("Text"))
    }
}
