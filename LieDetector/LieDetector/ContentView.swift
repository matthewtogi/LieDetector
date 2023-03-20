//
//  ContentView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Lie Detector")
                    .foregroundColor(Color(.white))
                    .fontWeight(.bold)
                    .font(.system(size: 48))
                
                Button{
                    
                }label:{
                   Text("")
                        .frame(maxWidth: 111, maxHeight: 111)
                }
                .background(.orange)
                .cornerRadius(80)
                .padding(.top, 20)
                
                Text("Tap to record")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 20))
                    .padding(.top, 8)
                
                
                HStack(spacing: 15){
                    Image("red-heart-icon")
                        .resizable()
                        .frame(width: 55, height: 50)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Heartbeat")
                            .foregroundColor(.white)
                        Text("81 BPM")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        
                    }
                }.background(.gray.opacity(0.5))
                
                
            }
        
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
