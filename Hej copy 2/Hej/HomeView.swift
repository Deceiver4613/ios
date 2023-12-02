//
//  HomeView.swift
//  Hej
//
//  Created by Ouimin Lee on 12/2/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color.black
                    .ignoresSafeArea()
                UserManual()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
/*
struct Demo: View {

    let fileUrl = Bundle.main.url(forResource: "demo1", withExtension: "mp4")!
    
    var body: some View {
        VStack {
            HStack{
//                VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
//                VideoPlayer(player: AVPlayer(url: fileUrl))
            }
        }
    }
}
*/
