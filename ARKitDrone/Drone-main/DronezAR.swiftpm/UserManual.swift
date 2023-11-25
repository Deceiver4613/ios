import SwiftUI

struct UserManual: View {
    var body: some View {
        // ZStack은 뷰를 겹쳐서 표시하는 데 사용됩니다.
        ZStack {
            Color.white // ZStack의 배경색상 (이 경우 흰색).

            // 다른 ZStack은 전체 화면을 채우고 배경 이미지를 설정합니다.
            ZStack{}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()

            // VStack은 뷰를 수직으로 배열하는 데 사용됩니다.
            VStack(spacing: 30) {
                // HStack은 이미지 로고("DronezAR")를 표시합니다.
                HStack {
                    Image("DronezAR")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }.padding()

                // 드론 이미지를 나타냅니다.
                Image("drone")
                    .resizable()
                    .frame(width: 400, height: 250)

                // NavigationLink를 사용하여 탭하면 'HowToPlayView'로 전환됩니다.
                NavigationLink(destination: HowToPlayView()) {
                    HStack {
                        Text("사용 방법")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    )
                }

                // NavigationLink를 사용하여 탭하면 'DroneARView'로 전환됩니다.
                NavigationLink(destination: DroneARView()) {
                    HStack {
                        Text("날아가기")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .background(.white)
                    .cornerRadius(30)
                }

                // NavigationLink를 사용하여 탭하면 'DemoVideo'로 전환됩니다.
                NavigationLink(destination: DemoVideo()) {
                    HStack {
                        Text("데모 시청")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .underline()
                    }
                }
            }
        }
    }
}
