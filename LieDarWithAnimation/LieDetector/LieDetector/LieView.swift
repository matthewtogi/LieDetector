//
//  TruthView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct LieView: View {
    @State private var heartRate = Int.random(in: 70...130)
    @State private var isPressed = false
    @State private var isReleased = false
    @State private var randomCount = Int.random(in: 0...4)
    @State private var sentences = ["If you plan to deceive, ain’t no way you can run away from Liedar, your ultimate truth serum. Now go tell them the truth 😉.", "Friedrich Nietzsche once said, I'm not upset that you lied to me, I'm upset that from now on I can't believe you.", "You may tell the greatest lies and wear a brilliant disguise, but you can't escape Liedar.", "Boohoo! Liar!", "Some liars are so expert, but not in front of Liedar!"]
    @Binding var speechToText: String
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.red
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.87)
                
                VStack{
                    Text("This person is")
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Text("LYING")
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                    
                    Text("🤥")
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

struct LieView_Previews: PreviewProvider {
    static var previews: some View {
        LieView(speechToText: .constant("Text"))
    }
}
