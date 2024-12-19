
import SwiftUI

struct Update2Password: View {
    
      @State private var newPassword = ""
      @State private var confirmPassword = ""
      @State private var isCodeVerified = false
      @State private var showAlert = false
      @State private var alertMessage = ""
    @State private var isResetPasswordPresented = false

      @State private var nextView: ViewStack? = nil


      enum ViewStack {
          case SignInView
      }
    
    var body: some View {
        VStack{
            Image("reset")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .padding(.bottom, 1)
                .padding(.top ,120)
                
          
            .padding(.leading, 4)
            .padding(.bottom, 60)
            HStack{
                Text("Entrer votre nouveau mot de passe ! ")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.bottom, 15)
            
            TextField("", text: $newPassword,
                      prompt: Text("Nouveau mot de passe")
                
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
           
            HStack{
                Text("Confirmer votre mot de passe !")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.bottom, 15)
            
            TextField("", text: $confirmPassword,
                      prompt: Text("Confirmer mot de passe")
                
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
                    validateAndChangePassword()

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
                            nextView = .SignInView
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
  
    private func validateAndChangePassword() {
        if newPassword.isEmpty || confirmPassword.isEmpty{
            alertMessage = "Les champs ne doivent pas etre vides"
            showAlert = true
            return
        }
     
         }
     }
/*
 userViewModel.forgotPassword(email: email) { result in
     switch result {
     case .success(let message):
         print("Password reset code sent: \(message)")
         showAlert = true
         alertMessage = "Code envoyé avec succès!"
         nextView = .UpdatePassword

     case .failure(let error):
         print("Error sending password reset code: Réessayer")
         showAlert = true
         alertMessage = "Envoi de code a échoué: Réessayer "
     }
 }
 */

#Preview {
    Update2Password()
}
