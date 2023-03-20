//
//  ContentView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var heartRate = Int.random(in: 70...120)
    @State private var isPressed = false
    @State private var isRecording = false
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.87)
            
            VStack{
                Text("Team 31")
                    .foregroundColor(lightBlue)
                Text("Lie Detector")
                    .foregroundColor(Color(.white))
                    .fontWeight(.bold)
                    .font(.system(size: 48))
                
                ZStack {
                    Button{
                        
                    }label:{
                        Text("")
                            .frame(maxWidth: 130, maxHeight: 130)
                    }
                    .background(.orange)
                    .cornerRadius(80)
                    .padding(.top, 20)
                }
                .scaleEffect(isPressed ? 1.05 : 1.0)
                .opacity(isPressed ? 0.6 : 1.0)
                .onTapGesture {
                    //taroh action dsni
                }
                .pressEvents {
                    // On press
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                        isRecording = true
                    }
                } onRelease: {
                    withAnimation {
                        isPressed = false
                        isRecording = false
                    }
                }

                if(isRecording == false){
                    Text("Tap to record")
                        .foregroundColor(Color(.gray))
                        .font(.system(size: 20))
                        .padding(.top, 8)
                } else {
                    Text("Release to stop recording")
                        .foregroundColor(Color(.gray))
                        .font(.system(size: 20))
                        .padding(.top, 8)
                }
                
                
                
                HStack(spacing: 15){
                    Image("red-heart-icon")
                        .resizable()
                        .frame(width: 40, height: 37)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Heartbeat")
                            .foregroundColor(.white)
                        Text("\(heartRate) BPM")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        
                    }
                }
                .padding(30)
                .background(.gray.opacity(0.4))
                .frame(height: 100)
                .cornerRadius(20)
                .padding(.top, 30)
                .padding(.bottom, 30)
                
                Text("\"Matthew said he didn't eat my salad, did he lie?\"")
                    .foregroundColor(Color(.gray))
                    .frame(maxWidth: 350)

            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
