
import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = MainViewModel.shared;
    
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
            .resizable()
            .scaledToFill()
            .frame(width: .screenWidth, height: .screenHeight)
            
            
            VStack{

                Image("subscribe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height : 170)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                Text("Sign Up ")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(Fonts.darkGreen)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your credentials to continue")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(Color.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                LineTextField( title: "username", placholder: "Enter your username", txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineTextField( title: "Email", placholder: "Enter your email address", txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureField( title: "Password", placholder: "Enter your password", txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                    .padding(.bottom, .screenWidth * 0.02)
                
                
                NavigationLink {
                    UpdatePassword()
                } label: {
                    Text("Forgot Password?")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(Color.gray)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                RoundButton(title: "Sign Up") {
                    //loginVM.serviceCallLogin()
                }
                .padding(.bottom, .screenWidth * 0.05)
                
                               
                
                Spacer()
            }
            .padding(.top, .topInsets + 1)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
            
         
           
            
            
        }
       
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            SignUpView()
        }
        
    }
}
