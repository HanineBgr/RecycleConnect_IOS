import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationStack { // Use NavigationStack for SwiftUI navigation
            ZStack {
           Image("welcome")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                // Content
                VStack {
                    Spacer()
                    
                    // Welcome text
                    Text("Welcome to\nRecycleConnect")
                        .font(.customfont(.semibold, fontSize: 40))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    // Subtitle text
                    Text("Link up with charity and events to donate")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    
                    // Navigation button to SignInView
                    NavigationLink {
                        SignInView() // Ensure SignInView exists and is implemented
                    } label: {
                        Text("Get Started")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                            .background(Fonts.darkGreen)
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                        .frame(height: 80)
                }
            }
            .navigationBarHidden(true) // Hides the navigation bar for the onboarding screen
        }
    }
}

// Preview
struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
