//
//  ContentView.swift
//  Introduction

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ZStack {
            Color.black
                 .ignoresSafeArea()
            UserManual()
        }
        }
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