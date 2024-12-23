
import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var txtEmail = ""
    @State private var txtPassword = ""
    @State private var isShowPassword = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    @State private var isLoggedIn = false
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                
                Image("login")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height : 150)
                    .padding(.bottom, .screenWidth * 0.1)
                
                Text("Sign in")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(Color.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your email and password")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(Color.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                LineTextField(title: "Email", placholder: "Enter your email address", txt: $txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureField(title: "Password", placholder: "Enter your password", txt: $txtPassword, isShowPassword: $isShowPassword)
                    .padding(.bottom, .screenWidth * 0.02)
                
                NavigationLink {
                   // ForgotPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(Fonts.darkGreen)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) { // Navigation to HomeView
                    RoundButton(title: "Log In") {
                        isLoggedIn = true
                    }
                    .padding(.bottom, .screenWidth * 0.05)
                }
                
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        Text("Don’t have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(Fonts.darkGreen)
                        
                        Text("Signup")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(Fonts.darkGreen)
                    }
                }
                
                Spacer()
            }
            .padding(.top, .topInsets + 40)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
        }
        .alert(isPresented: $showError) {
            Alert(title: Text(Globs.AppName), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
