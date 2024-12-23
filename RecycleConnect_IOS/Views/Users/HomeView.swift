import SwiftUI

struct HomeView: View {
    let exclusiveProducts: [ProductModel] = [
        ProductModel(dict: ["image": "sofa", "name": "Luxury Sofa", "unitValue": "3", "unitName": "pcs", "price": 200.99, "offerPrice": 150.99]),
        ProductModel(dict: ["image": "table", "name": "Dining Table", "unitValue": "1", "unitName": "set", "price": 120.00, "offerPrice": 99.00]),
        ProductModel(dict: ["image": "sofa", "name": "Stylish Lamp", "unitValue": "1", "unitName": "unit", "price": 30.00, "offerPrice": 25.00]),
        ProductModel(dict: ["image": "chair", "name": "Comfort Chair", "unitValue": "2", "unitName": "pcs", "price": 80.00, "offerPrice": 65.00]),
        ProductModel(dict: ["image": "carpet", "name": "Modern Carpet", "unitValue": "1", "unitName": "piece", "price": 50.00, "offerPrice": 40.00])
    ]
    
    let bestSellingProducts: [ProductModel] = [
        ProductModel(dict: ["image": "subscribe", "name": "Premium Subscription", "unitValue": "1", "unitName": "year", "price": 120.00, "offerPrice": 99.00]),
        ProductModel(dict: ["image": "tv", "name": "Smart TV", "unitValue": "1", "unitName": "unit", "price": 500.00, "offerPrice": 450.00]),
        ProductModel(dict: ["image": "headphones", "name": "Wireless Headphones", "unitValue": "1", "unitName": "unit", "price": 60.00, "offerPrice": 45.00]),
        ProductModel(dict: ["image": "watch", "name": "Smart Watch", "unitValue": "1", "unitName": "unit", "price": 150.00, "offerPrice": 120.00]),
        ProductModel(dict: ["image": "camera", "name": "Digital Camera", "unitValue": "1", "unitName": "unit", "price": 300.00, "offerPrice": 280.00])
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HStack(spacing: 10) {
                            Image("u2")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            
                            Text("Welcome Hanine 👋")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.top, 60)
                        .padding(.horizontal, 20)
                        
                        // Search Bar
                        SearchTextField(placholder: "Search Store", txt: .constant(""))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        
                        Spacer().frame(height: 5)
                        
                        ZStack {
                            Image("CTA")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 125)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("You have items that you\ndon’t need anymore?")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 15)
                                    
                                    Button(action: {
                                        print("Explore button tapped")
                                    }) {
                                        Text("Explore")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 16)
                                            .background(Color(#colorLiteral(red: 0.35, green: 0.58, blue: 0.54, alpha: 1)))
                                            .cornerRadius(25)
                                            .padding(.leading, 15)
                                    }
                                    .padding(.top, 8)
                                }
                                
                                Spacer()
                                
                                Image("explore")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 100)
                                    .padding(.trailing, 18)
                                    .offset(y: 0)
                            }
                            .padding(.horizontal, 20)
                        }
                        .frame(height: 135)
                        .padding(.top, 5)
                        
                        Spacer().frame(height: 20)
                        
                        // Exclusive Offers Section
                        SectionTitleAll(title: "Exclusive Offer", titleAll: "See All") {}
                            .padding(.horizontal, 20)
                        
                       
                        // Best Selling Section
                        SectionTitleAll(title: "Best Selling", titleAll: "See All") {}
                            .padding(.horizontal, 20)
                        
                     
                    }
                }
            }
            .ignoresSafeArea()
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }

}
}

