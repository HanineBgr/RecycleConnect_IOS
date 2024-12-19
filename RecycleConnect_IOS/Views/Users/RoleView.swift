import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

struct RoleView: View {

    @State private var navigateToSignUp = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) { }
                    .frame(width: 400, height: 150)
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 270)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(Fonts.darkGreen), lineWidth: 3)
                        )
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Vous etes:")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                            Text("Client")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        Image("user")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .offset(x: 60)
                        Button {
                            navigateToSignUp = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(Fonts.darkGreen)
                                Text("Continuer")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 18))
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 35)
                    }
                    .padding()
                }
                .padding(.bottom, 15)
                .padding(.top, -20)
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 270)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(Fonts.darkGreen), lineWidth: 3)
                        )
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Vous etes : ")
                                .fontWeight(.medium)
                                .font(.system(size: 18))
                            Text("Organisation")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        Image("org")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .offset(x: 60)
                        Button {
                            navigateToSignUp = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(Fonts.darkGreen)
                                Text("Continuer")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 18))
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 35)
                    }
                    .padding()
                }
                Spacer()
            }
            .background(.white)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
            }
        }
    }
}


#Preview {
    RoleView()
}
