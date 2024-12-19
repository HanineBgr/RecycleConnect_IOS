import SwiftUI

struct ArticlesDetailsView: View {
    @State var quantity = 1
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Image("sofa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .padding(.top, -100) // Moved the image a bit to the top
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Canapé jamais utilisé")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Style moderne")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                        Text("341 Seen")
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("294 Liked")
                    }

                    Text("Encore dans son emballage d'origine, n'ayant jamais servi. Il peut être neuf, avec une finition impeccable et sans aucune usure.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)

                HStack {
                    Button(action: {
                        quantity = max(1, quantity - 1)
                    }) {
                        Text("-")
                            .foregroundColor(.black)
                            .frame(width: 25, height: 40)
                            .background(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                    }

                    Text("\(quantity)")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)

                    Button(action: {
                        quantity += 1
                    }) {
                        Text("+")
                            .foregroundColor(.black)
                            .frame(width: 25, height: 40)
                            .background(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Total: $\(Int(Double(quantity) * 90.99))")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)

                Button(action: {
                    showAlert = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: 200, height: 40)
                            .foregroundColor(Fonts.darkGreen)
                        Text("Ajouter au panier")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                    }
                }
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Succès"),
                        message: Text("Ajouté avec succès au panier !"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            
        }
    }
}

struct ArticlesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesDetailsView()
    }
}
