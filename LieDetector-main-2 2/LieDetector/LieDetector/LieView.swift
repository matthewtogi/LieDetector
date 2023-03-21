//
//  LieView.swift
//  LieDetector
//
//  Created by Jason Leonardo on 20/03/23.
//

import SwiftUI

struct LieView: View {
    var body: some View {
        ZStack{
            Color.red
            .edgesIgnoringSafeArea(.all)
            .opacity(0.8)
            
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
                    Text("\"Matthew said he didn't eat my salad. Did he lie?\"")
                        .foregroundColor(Color(.white))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                        .italic()
                    
                    Text("This friend of yours is a big fat liar! Should you even consider them as your friend?🤔")
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
                        Text("123 BPM")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .bold))
                        
                    }
                }.padding(20)
                
                Button{
                    
                }label:{
                    Text("Back to Home")
                        .frame(maxWidth: 300, maxHeight: 40)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }.background(.white)
                    .buttonStyle(.bordered)
                    .cornerRadius(100)
                
            }
        }
    }
}

struct LieView_Previews: PreviewProvider {
    static var previews: some View {
        LieView()
    }
}
