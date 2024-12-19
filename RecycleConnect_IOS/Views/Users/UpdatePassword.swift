
import SwiftUI

struct UpdatePassword: View {
    
    @State private var isCodeVerified = false
        @State private var showAlert = false
        @State private var isResetPasswordPresented = false
        @State private var alertMessage = ""
        @State private var verificationCode: String = ""
        @State private var nextView: ViewStack? = nil

        enum ViewStack {
            case Update2Password
        }
        
    var body: some View {
        VStack{
            Image("reset")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .padding(.bottom, 1)
                .padding(.top ,180)
                
          
            .padding(.leading, 4)
            .padding(.bottom, 60)
            HStack{
                Text("Veuillez entrer le code d'abord ! ")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Spacer()
            }
            .padding(.leading, 35)
            .padding(.bottom, 15)
            
            TextField("", text: $verificationCode,
                      prompt: Text("*  *  *  *  *  *  *  *")
                
            )
            .disableAutocorrection(true)
            .frame(width: 300, height: 50)
            .padding(.leading, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(Fonts.darkGreen),
                            lineWidth: 1.5)
            )
            .padding(.bottom, 30)
           
            
            HStack {
                Button{
                    //validateAndVerifyCode()
                    
                    isResetPasswordPresented.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: 150, height: 40)
                            .foregroundColor(Fonts.darkGreen)
                        Text("Envoyer")
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                    }
                    
                    .alert(isPresented: $showAlert) {
                                            Alert(title: Text("Réinitialiser mot de passe"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                                                nextView = .Update2Password
                                            }))
                                        }
                                    }
                .padding(.leading, 130)
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    NavigationLink(
                        destination: Update2Password(),
                        isActive: $isResetPasswordPresented,
                        label: { EmptyView() }
                    )
                    .onChange(of: nextView) { value in
                        if value != nil {
                            isResetPasswordPresented = true
                        }
                    }
                )
            }

  
      }

 

#Preview {
    UpdatePassword()
}
