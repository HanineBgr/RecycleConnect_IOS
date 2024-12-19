

import SwiftUI
struct CustomNavigationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
    }
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue) 
        }
    }
}
struct ResetPassword: View {
    
    enum ResetPasswordStatus {
        case resetting
        case resetSent
        case error
    }
    enum ViewStack {
        case UpdatePassword
    }
    
  
    @Environment(\.presentationMode) var presentationMode
       @State private var isResetPasswordPresented = false
       @State private var showAlert = false
       @State private var alertMessage = ""
       @State private var verificationCode: String = ""
       @State private var email: String = ""
       @State private var emailError: String? = nil
       @State private var NavigateToUpdatepassword = false
       @State private var isResetCodeSent = false
       @State private var resetPasswordStatus: ResetPasswordStatus = .resetting

       @State private var presentNextView = false
       @State private var isCodeVerified = false
       @State private var nextView: ViewStack = .UpdatePassword
        @State private var isUpdatePasswordPresent = false

    var body: some View {
        NavigationView {
            VStack{
                Image("")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 1)
                    .padding(.top ,1)
                
                HStack{
                    Text("Veuillez entrer votre adresse mail")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 35)
                .padding(.bottom, 2)
                HStack{
                    Text("Un code vous sera envoyé! ")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundStyle(Color(Fonts.darkGreen))
                    
                    Spacer()
                }
                .padding(.leading, 35)
                .padding(.bottom, 15)
                
                Image("reset")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.bottom, 30)
                    .padding(.top , 40)
                    .padding(.leading, 1)
                
                    .padding(.leading, 35)
                TextField("", text: $email,
                          prompt: Text("Adresse mail")
                          
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
                if let error = emailError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.bottom, 1)
                    
                }
                
                HStack {
                    Button{
                        isResetPasswordPresented.toggle()
                        validInput()
                        sendPasswordReset()
                        
                    }
                    
                label: {
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
                        switch alertMessage {
                        case "Code envoyé avec succès!":
                            return Alert(
                                title: Text("Réinitialiser mot de passe"),
                                message: Text(alertMessage),
                                dismissButton: .default(
                                    Text("OK"),
                                    action: {
                                        isUpdatePasswordPresent = true
                                    }
                                )
                            )
                        case "":
                            return Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("")))
                        default:
                            return Alert(
                                title: Text("Erreur"),
                                message: Text(alertMessage),
                                dismissButton: .default(
                                    Text("OK")
                                )
                            )
                        }
                    }
                }
                .background(
                    NavigationLink("", destination: UpdatePassword(), isActive: $isUpdatePasswordPresent)
                        .opacity(0)
                        .buttonStyle(PlainButtonStyle())
                )
                }
            }}
    }
    private func sendPasswordReset() {
        guard emailError == nil && !email.isEmpty else {
            showAlert = true
            alertMessage = "Veuillez entrer une adresse email valide."
            return
        }

    }
    private func validInput() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if email.isEmpty {
            emailError = "Veuillez entrer votre adresse mail !"
        } else if !emailPredicate.evaluate(with: email) {
            emailError = "Adresse email invalide"
        } else {
            emailError = nil
        }
    }
   }


#Preview {
    ResetPassword()
}
