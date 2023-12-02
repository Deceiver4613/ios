//
//  UserManual.swift
//  Hej
//
//  Created by Ouimin Lee on 12/2/23.
//

import SwiftUI

struct UserManual: View {
    var body: some View {
        ZStack {
            Color.white
            ZStack{}
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Image("DroneAR")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }.padding()
                Image("drone")
                    .resizable()
                    .frame(width: 400, height: 250)
                           
                NavigationLink(destination: DroneARView()) {
                    
                    HStack {
                        Text("Play")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .background(.white)
                    .cornerRadius(30)
                    
                    
                    
                }
            }
            
        }
    }
}

