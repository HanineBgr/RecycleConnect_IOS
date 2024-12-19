import SwiftUI

struct DonationScreen: View {
    
    @State private var collectedAmount = 291.4
    @State private var participantCount = 143
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("livres")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 20)
            
            Text("Landslide Road Due to Heavy Rain, Let's Help!")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Barbie Ci")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Hanine Bouguerra")
                        .font(.headline)
                    Text("Verified User")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Fonts.darkGreen)
            }
            .padding(.bottom, 20)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Collected")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("$\(collectedAmount, specifier: "%.1f")")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Participation")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(participantCount) People")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 20)
            
            Text("There has been heavy rain in Barbie Ci and the road around the area collapsed and became unusable. Please help!")
                .font(.body)
                .padding(.bottom, 20)
            
            Button(action: {
            }) {
                Text("Donate Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Fonts.darkGreen)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct DonationScreen_Previews: PreviewProvider {
    static var previews: some View {
        DonationScreen()
    }
}
