import SwiftUI

struct CartView: View {
    @State private var items = [
        CartItem(image: "tv", name: "TV condor", brand: "Regal Do Lobo", price: 279.95, quantity: 4),
        CartItem(image: "sofa", name: "Canapé", brand: "Hatil-Loren", price: 258.91, quantity: 1),
        CartItem(image: "jacket", name: "Hiro Armchair", brand: "Hatil-Loren", price: 369.86, quantity: 3)
    ]
    @State private var shippingCost = 26.0

    var subtotal: Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }

    var totalPayment: Double {
        subtotal + shippingCost
    }

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($items) { $item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text(item.brand)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("$\(item.price, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }

                            Spacer()

                            HStack {
                                Button(action: {
                                    if item.quantity > 1 {
                                        item.quantity -= 1
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                }

                                Text("\(item.quantity)")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 30)

                                Button(action: {
                                    item.quantity += 1
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }

            VStack {
                VStack(spacing: 20) {
                    Text("Order Information")
                        .font(.headline)
                        .foregroundColor(.black)

                    HStack {
                        Text("Subtotal")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(subtotal, specifier: "%.2f")")
                            .foregroundColor(.black)
                    }

                    HStack {
                        Text("Shipping Cost")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$\(shippingCost, specifier: "%.2f")")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color.gray.opacity(0.5))
                )
                .cornerRadius(15)

                Divider()
                    .background(Color.gray.opacity(0.5))
                    .padding(.horizontal)
                    .frame(height: 1)

                HStack {
                    Text("Total Payment")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Text("$\(totalPayment, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding(.horizontal)

            NavigationLink(destination: CheckoutView()) {
                Text("Check Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Fonts.darkGreen)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let brand: String
    let price: Double
    var quantity: Int
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
