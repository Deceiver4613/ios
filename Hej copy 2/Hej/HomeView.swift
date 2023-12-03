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
