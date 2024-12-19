import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 8) {
                Image("profile")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 5)
                
                Text("Hanine Bouguerra")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("bouguerrahanine4@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 80)
            
            // Menu Options
            VStack(spacing: 16) {
                ProfileMenuItem(iconName: "person.crop.circle", title: "Profile")
                ProfileMenuItem(iconName: "creditcard", title: "Payment Methods")
                ProfileMenuItem(iconName: "bag", title: "Order History")
                ProfileMenuItem(iconName: "house", title: "Delivery Address")
                ProfileMenuItem(iconName: "questionmark.circle", title: "Support Center")
                ProfileMenuItem(iconName: "lock.shield", title: "Legal Policy")
            }
            .padding(.horizontal, 25)

            Button(action: {
                print("Log Out tapped")
            }) {
                Text("Log Out")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            .padding(.bottom, 80)
        }
        .background(Color(.systemGroupedBackground))
        .overlay(
            VStack {
                CustomToolbar()
                    
            }
        )
    }
}

struct ProfileMenuItem: View {
    let iconName: String
    let title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(Fonts.darkGreen)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.body)
                .foregroundColor(Color(UIColor.darkGray))

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
