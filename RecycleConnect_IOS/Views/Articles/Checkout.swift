import SwiftUI

struct CheckoutView: View {
    @State private var selectedPaymentMethod = "Credit Card"
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Shipping to")
                                .font(.headline)
                                .foregroundColor(.black)

                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Fonts.darkGreen)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Home Address")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text("(216) 93150160")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Belt road Sousse")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        }

                        VStack(alignment: .leading) {
                            Text("Payment Method")
                                .font(.headline)
                                .foregroundColor(.black)

                            VStack(spacing: 10) {
                                PaymentMethodRow(icon: "creditcard.fill", title: "Credit Card", isSelected: selectedPaymentMethod == "Credit Card") {
                                    selectedPaymentMethod = "Credit Card"
                                }

                                PaymentMethodRow(icon: "paypal", title: "Paypal", isSelected: selectedPaymentMethod == "Paypal") {
                                    selectedPaymentMethod = "Paypal"
                                }

                                PaymentMethodRow(icon: "applelogo", title: "Apple Pay", isSelected: selectedPaymentMethod == "Apple Pay") {
                                    selectedPaymentMethod = "Apple Pay"
                                }

                                HStack {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.black)
                                        .frame(width: 30, height: 30)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())

                                    Text("Other")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                        }

                        VStack {
                            HStack {
                                Text("Item Total")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("$367.65")
                                    .foregroundColor(.black)
                            }
                            HStack {
                                Text("Delivery Fee")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("$80.00")
                                    .foregroundColor(.black)
                            }
                            Divider()
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("$447.99")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                }

                Button(action: {
                    showAlert.toggle()
                }) {
                    Text("Payment")
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Payment Successful"),
                    message: Text("Your payment was successful! Your items will be delivered soon. 🚚"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct PaymentMethodRow: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.2))
                .clipShape(Circle())

            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            if isSelected {
                Image(systemName: "circle.fill")
                    .foregroundColor(Fonts.darkGreen)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
