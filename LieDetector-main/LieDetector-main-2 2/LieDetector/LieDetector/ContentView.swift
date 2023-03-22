//
//  ContentView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var heartRate = 88
    @State private var isPressed = false
    @State private var isRecording = false
    @State private var hasRecorded = false
    @State private var showNextViewRNG = 0
    @State private var buttonTapCount = 0
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1)
                
                VStack{
                    Text("Team 31")
                        .foregroundColor(lightBlue)
                    Text("Lie Detector")
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                        .font(.system(size: 48))
                    
                    
                    if showNextViewRNG == 1{
                        VStack{
                            NavigationLink(destination: TruthView()){
                                Text("")
                                    .frame(maxWidth: 130, maxHeight: 130)
                                    .background(.orange)
                                    .cornerRadius(80)
                                    .padding(.top, 20)
                                
                                
                            }
                            Text("Tap again to finish")
                                .foregroundColor(.gray)
                                .padding()
                            
                        }
                        
                    }
                    else if showNextViewRNG == 2{
                        VStack{
                            NavigationLink(destination: LieView()){
                                Text("")
                                    .frame(maxWidth: 130, maxHeight: 130)
                                    .background(.orange)
                                    .cornerRadius(80)
                                    .padding(.top, 20)
                                
                                
                            }
                            Text("Tap again to finish")
                                .foregroundColor(.gray)
                                .padding()
                            
                        }
                        
                    }
                    else{
                        ZStack {
                            Button{
                                
                            }label:{
                                Text("").tag(1)
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
                                Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true){
                                    _ in heartRate += randomHeartbeat()
                                }
                                
                            }
                        } onRelease: {
                            withAnimation {
                                isPressed = false
                                isRecording = false
                                showNextViewRNG = Int.random(in: 1...2)
                                
                            }
                            
                        }
                        Text("Tap to record")
                            .foregroundColor(.gray)
                            .padding()
                        
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
                if(isRecording == false && hasRecorded == true){
                    Text("Tap to record")
                        .foregroundColor(Color(.gray))
                        .font(.system(size: 20))
                        .padding(.top, 8)
                    TruthView()
                    
                }
                
            }
            
        }.navigationTitle("")
            .navigationBarBackButtonHidden()
        
        
    }
    
    
    func randomHeartbeat() -> Int{
        let heartBeatRandom = Int.random(in: -5...6)
        return heartBeatRandom
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
