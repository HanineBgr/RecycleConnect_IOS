import SwiftUI

struct HomeView: View {
    @State private var nearYouItems: [CharityItem] = [
        CharityItem(image: "bag", title: "Top", description: "Zeineb Salah"),
        CharityItem(image: "sofa", title: "Canapé", description: "Mourad Sabeur"),
        CharityItem(image: "converse", title: "Black Converse", description: "Hanine Bouguerra")
    ]
    @State private var popularItems: [CharityItem] = [
        CharityItem(image: "tel", title: "Téléphone", description: "IPRO mini"),
        CharityItem(image: "tv", title: "Télévision", description: "TV condor 42 pouces"),
        CharityItem(image: "sofa", title: "Canapé", description: "Canapé jamis utilisé")
    ]
    @State private var events: [CharityEvent] = [
        CharityEvent(image: "event", title: "Event 1", description: "Description 1"),
        CharityEvent(image: "event", title: "Event 2", description: "Description 2")
    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image("profile")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Hi Hanine Bouguerra ")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack(spacing: 10) {
                            ForEach(Category.allCases, id: \.self) { category in
                                Button(action: {}) {
                                    HStack(spacing: 5) {
                                        Image(systemName: category.iconName)
                                            .foregroundColor(category == .furniture ? .white : .gray)
                                        Text(category.title)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(category == .furniture ? .white : .gray)
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 3)
                                    .background(category == .furniture ? Fonts.darkGreen : Color(.systemGray6))
                                    .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Near You")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: {}) {
                                    Text("View All")
                                        .font(.footnote)
                                        .foregroundColor(Fonts.darkGreen)
                                }
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(nearYouItems) { item in
                                        NavigationLink(destination: ArticlesDetailsView()) {
                                            CharityItemView(item: item)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Popular")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: {}) {
                                    Text("View All")
                                        .font(.footnote)
                                        .foregroundColor(Fonts.darkGreen)
                                }
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(popularItems) { item in
                                        NavigationLink(destination: ArticlesDetailsView()) {
                                            CharityItemView(item: item)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }

                CustomToolbar()
                    .frame(height: 70)
            }
            .navigationBarItems(leading: Text("Home")
                                        .font(.headline)
                                        .bold(),
                                trailing: Image(systemName: "bell.fill"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct CharityItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct CharityEvent: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct CharityItemView: View {
    let item: CharityItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .cornerRadius(12)
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(item.description)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct CharityEventView: View {
    let event: CharityEvent

    var body: some View {
        Image(event.image)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 150)
            .cornerRadius(15)
    }
}

enum Category: CaseIterable {
    case furniture, clothes, shoes, other

    var title: String {
        switch self {
        case .furniture: return "Furniture"
        case .clothes: return "Clothes"
        case .shoes: return "Shoes"
        case .other: return "Other"
        }
    }

    var iconName: String {
        switch self {
        case .furniture: return "bed.double.fill"
        case .clothes: return "tshirt.fill"
        case .shoes: return "shoeprints.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }
}

#Preview {
    HomeView()
}
