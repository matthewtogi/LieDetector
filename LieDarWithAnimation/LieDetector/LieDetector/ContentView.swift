//
//  ContentView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI
import Speech
import AVFoundation

struct ContentView: View {
    @State private var heartRate = Int.random(in: 70...110)
    @State private var isPressed = false
    @State private var isRecording = false
    @State private var hasRecorded = false
    @State private var showNextViewRNG = 0
    @State private var buttonTapCount = 0
    @State private var speechToText = ""
    @State private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()
    
    var permission: Void {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            print("Permission granted")
        case .denied:
            print("Permission denied")
        case .undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                // Handle granted
            })
        @unknown default:
            print("Unknown case")
        }
        
        
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.orange
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1)
                
                LottieLoopView(animationName: "Heart Rate Clean")
                    .padding(.top, 300)
                
                VStack{
                    
                    Text("Team 31")
                        .foregroundColor(lightBlue)
                        .font(Font.custom("Moon Bold", size: 22))
                    Text("LieDar")
                        .font(Font.custom("Moon Bold", size: 58))
                        .foregroundColor(Color(.white))
                        .fontWeight(.bold)
                    
                    
                    
                    if showNextViewRNG == 1{
                        VStack{
                            NavigationLink(destination: TruthView(speechToText: $speechToText)){
                                Image("play-button")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                //                                ZStack{
                                //                                    LottieLoopView(animationName: "Wave")
                                //                                    Image("play-button")
                                //                                        .resizable()
                                //                                        .frame(width: 200, height: 200)
                                //
                                //                                }
                            }
                            
                            
                            Text("Tap again to finish")
                                .foregroundColor(.black)
                                .padding()
                                .font(Font.custom("Moon Bold", size: 22))
                            
                            
                        }
                        
                    }
                    else if showNextViewRNG == 2{
                        VStack{
                            NavigationLink(destination: LieView(speechToText: $speechToText)){
                                Image("play-button")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                //                                ZStack{
                                //                                    LottieLoopView(animationName: "Wave")
                                //                                    Image("play-button")
                                //                                        .resizable()
                                //                                        .frame(width: 200, height: 200)
                                //
                                //                                }
                                
                                
                                
                            }
                            Text("Tap again to finish")
                                .foregroundColor(.black)
                                .padding()
                                .font(Font.custom("Moon Bold", size: 22))
                            
                        }
                        
                    }
                    else{
                        
                        ZStack {
                            Button{
                                
                            }label:{
                                Image("play-button")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            }
                            
                        }
                        .scaleEffect(isPressed ? 1.05 : 1.0)
                        .opacity(isPressed ? 0.6 : 1.0)
                        .onTapGesture {
                            //taroh action dsni
                        }
                        .pressEvents {
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
                                
                                startRecording()
                                
                            }
                            
                        }
                        Text("Tap to record")
                            .foregroundColor(.black)
                            .font(Font.custom("Moon Bold", size: 22))
                            .padding()
                        
                    }
                    
                    
                    HStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 5){
                            Text("Heart Rate")
                                .foregroundColor(.black)
                                .font(Font.custom("Moon Bold", size: 22))
                            
                            if showNextViewRNG == 1 || showNextViewRNG == 2{
                                Text("\(heartRate) BPM")
                                    .font(Font.custom("Moon Bold", size: 32))
                                    .foregroundColor(.black)
                                
                            }
                            else{
                                Text("- BPM")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Moon Bold", size: 32))
                            }
                            
                            
                        }
                    }
                    .padding(30)
                    //                    .background(.gray.opacity(0.4))
                    .frame(height: 100)
                    .cornerRadius(20)
                    .padding(.top, 30)
                    .padding(.bottom, 100)
                    
                    
                    
                    
                    
                }
                Text("\(speechToText)")
                    .foregroundColor(Color(.gray))
                    .frame(maxWidth: 350)
                    .padding(.top, 500)
                    .italic()
                
            }
            
        }.navigationTitle("")
            .navigationBarBackButtonHidden()
        
        
    }
    
    
    func randomHeartbeat() -> Int{
        let heartBeatRandom = Int.random(in: -5...6)
        return heartBeatRandom
    }
    
    func startRecording() {
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        recognitionTask = nil
        
        // Configure the audio session for recording.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: [.duckOthers, .defaultToSpeaker])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error)")
            return
        }
        
        // Set up the audio engine input node and buffer.
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        // Prepare the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Start the recognition task.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.speechToText = result.bestTranscription.formattedString
            } else if let error = error {
                print("Recognition task error: \(error)")
            }
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("Failed to start audio engine: \(error)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
