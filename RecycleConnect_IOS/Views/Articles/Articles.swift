import SwiftUI

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let price: Double
}

struct ArticleCard: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 70)
            
            Text(article.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 8)

            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)

            Text("Price: $\(article.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .padding(.top, 8)
        }
        .padding()
        .frame(width: 170, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 4)
    }
}

struct ArticlesView: View {
    let articles = [
        Article(title: "Georg Jensen Minimal Chair", description: "A stylish and comfortable chair.", image: "sofa", price: 299.99),
        Article(title: "Pearly Beading Fox Chair", description: "A unique and eye-catching chair.", image: "tel", price: 349.99),
        Article(title: "Classic Wooden Table", description: "A durable and elegant table.", image: "jacket", price: 199.99),
        Article(title: "Leather Sofa Set", description: "A luxurious leather sofa set.", image: "tv", price: 999.99),
        Article(title: "Leather Sofa Set", description: "A luxurious leather sofa set.", image: "sofa", price: 999.99),
        Article(title: "Leather Sofa Set", description: "A luxurious leather sofa set.", image: "converse", price: 999.99)
    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 20)], spacing: 20) {
                        ForEach(articles) { article in
                            ArticleCard(article: article)
                        }
                    }
                    .padding()
                }

                Spacer() // Ensures the toolbar stays at the bottom
                CustomToolbar()
                    .frame(height: 70) // Adjust height as needed
            }
                   }
    }
}



struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
