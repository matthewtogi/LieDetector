//
//  ContentView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI
import Speech

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
                            NavigationLink(destination: TruthView(speechToText: $speechToText)){
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
                            NavigationLink(destination: LieView(speechToText: $speechToText)){
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
                            .foregroundColor(.gray)
                            .padding()
                        
                    }
                    
                    
                    
                    
                    
                    HStack(spacing: 15){
                        Image("red-heart-icon")
                            .resizable()
                            .frame(width: 40, height: 37)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Heart Rate")
                                .foregroundColor(.white)
                            
                            if showNextViewRNG == 1 || showNextViewRNG == 2{
                                Text("\(heartRate) BPM")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold))
                            }
                            else{
                                Text("- BPM")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold))
                            }
                            
                            
                        }
                    }
                    .padding(30)
                    .background(.gray.opacity(0.4))
                    .frame(height: 100)
                    .cornerRadius(20)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    
                   
                    Text("\(speechToText)")
                        .foregroundColor(Color(.gray))
                        .frame(maxWidth: 350)
                        .italic()
                    
                    
                }
               
                
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
