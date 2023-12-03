//
//  HowToPlay.swift
//  Hej
//
//  Created by Ouimin Lee on 12/2/23.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ZStack {
            ZStack{}
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()
                .navigationTitle("How to use")
                
            TabView {
                OnboardingStepView(image: "step1", title: "전원 켜기", description: "드론의 전원을 켜려면 앱에서 전원 켜기 버튼을 누르세요. 드론이 켜지면 표시등이 녹색으로 변합니다.")
                OnboardingStepView(image: "step2", title: "왼쪽 조이스틱", description: "드론의 고도와 회전을 제어하려면 왼쪽 조이스틱을 사용하세요. 조이스틱을 위로 밀면 드론이 상승하고, 아래로 밀면 하강합니다. 또한 조이스틱을 왼쪽이나 오른쪽으로 움직여 드론을 회전시킬 수 있습니다.")
                OnboardingStepView(image: "step3", title: "오른쪽 조이스틱", description: "드론의 이동을 제어하려면 오른쪽 조이스틱을 사용하세요. 조이스틱을 앞으로 밀면 드론이 전진하고, 뒤로 당기면 드론이 후진합니다. 또한 조이스틱을 왼쪽이나 오른쪽으로 움직여 드론을 좌우로 이동시킬 수 있습니다.")
                OnboardingStepView(image: "step4", title: "원위치로 돌아가기", description: "드론의 이동을 일시 중지하고 원래 위치로 돌아가려면 앱에서 일시 중지 버튼을 누르세요. 드론은 자동으로 이륙 지점으로 되돌아갑니다.")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct OnboardingStepView: View {
    var image: String
    var title: String
    var description: String

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                VStack {
                    VStack(spacing: 18) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        
                        Text(description)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        
                    }
                    .padding()
                    .background(.white).cornerRadius(10)
                    Spacer()
                }
                
              
            }
            .padding()
            
            
        }
    }
}
