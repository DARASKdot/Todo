import SwiftUI

struct UserView: View {
    @State var text:String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Hello!")
            Text("だらすく")
                .font(.title)
            TextField("文字入れてね", text: $text)
                .multilineTextAlignment(.trailing)
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(text: "test")
    }
}
