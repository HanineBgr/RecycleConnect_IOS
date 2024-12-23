

import SwiftUI

struct SearchTextField: View {
   
    @State var placholder: String = "Placholder"
    @Binding var txt: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
           
            TextField(placholder, text: $txt)
                .font(.customfont(.regular, fontSize: 17))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 18)
        .padding(15)
        .background(Fonts.darkGreen)
        .cornerRadius(16)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View {
        SearchTextField(placholder: "Search for items here", txt: $txt)
            .padding(15)
    }
}
