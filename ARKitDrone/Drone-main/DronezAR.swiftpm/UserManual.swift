import SwiftUI

struct UserManual: View {
    var body: some View {
        // ZStack�� �並 ���ļ� ǥ���ϴ� �� ���˴ϴ�.
        ZStack {
            Color.white // ZStack�� ������ (�� ��� ���).

            // �ٸ� ZStack�� ��ü ȭ���� ä��� ��� �̹����� �����մϴ�.
            ZStack{}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("bg").resizable())
                .ignoresSafeArea()

            // VStack�� �並 �������� �迭�ϴ� �� ���˴ϴ�.
            VStack(spacing: 30) {
                // HStack�� �̹��� �ΰ�("DronezAR")�� ǥ���մϴ�.
                HStack {
                    Image("DronezAR")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }.padding()

                // ��� �̹����� ��Ÿ���ϴ�.
                Image("drone")
                    .resizable()
                    .frame(width: 400, height: 250)

                // NavigationLink�� ����Ͽ� ���ϸ� 'HowToPlayView'�� ��ȯ�˴ϴ�.
                NavigationLink(destination: HowToPlayView()) {
                    HStack {
                        Text("��� ���")
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

                // NavigationLink�� ����Ͽ� ���ϸ� 'DroneARView'�� ��ȯ�˴ϴ�.
                NavigationLink(destination: DroneARView()) {
                    HStack {
                        Text("���ư���")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(width: 300)
                    .background(.white)
                    .cornerRadius(30)
                }

                // NavigationLink�� ����Ͽ� ���ϸ� 'DemoVideo'�� ��ȯ�˴ϴ�.
                NavigationLink(destination: DemoVideo()) {
                    HStack {
                        Text("���� ��û")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .underline()
                    }
                }
            }
        }
    }
}
