import SwiftUI

struct CustomToolbar: View {
    @State private var selectedTab: String = "Home"
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 50) {
                // Home Button
                NavigationLink(destination: HomeView()) {
                    VStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(selectedTab == "Home" ? Color.primary : .gray)
                        Text("Home")
                            .font(.footnote)
                            .foregroundColor(selectedTab == "Home" ? Color.primary : .gray)
                            .padding(.top, 2)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectedTab = "Home"
                })

                // Article Button
                NavigationLink(destination: ArticlesView()) {
                    VStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(selectedTab == "Articles" ? Color.primary : .gray)
                        Text("Article")
                            .font(.footnote)
                            .foregroundColor(selectedTab == "Articles" ? Color.primary : .gray)
                            .padding(.top, 2)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectedTab = "Articles"
                })

                // Donate Button
                NavigationLink(destination: ProfileView()) {
                    VStack {
                        Image(systemName: "gift.fill")
                            .foregroundColor(selectedTab == "Donate" ? Color.primary : .gray)
                        Text("Donate")
                            .font(.footnote)
                            .foregroundColor(selectedTab == "Donate" ? Color.primary : .gray)
                            .padding(.top, 2)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectedTab = "Donate"
                })

                // Profile Button
                NavigationLink(destination: ProfileView()) {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(selectedTab == "Profile" ? Color.primary : .gray)
                        Text("Profile")
                            .font(.footnote)
                            .foregroundColor(selectedTab == "Profile" ? Color.primary : .gray)
                            .padding(.top, 2)
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectedTab = "Profile"
                })
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -4)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomToolbar()
        }
        .previewLayout(.sizeThatFits)
    }
}
