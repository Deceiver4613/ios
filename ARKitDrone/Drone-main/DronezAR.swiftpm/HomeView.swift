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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
