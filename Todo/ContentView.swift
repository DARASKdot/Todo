

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            UserView(image: Image("profile"),userName: "だらすく")
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    CategoryView(category: .ImpUrg_1st)
                    Spacer()
                    CategoryView(category: .ImpNUrg_2nd)
                }
                Spacer()
                HStack(spacing: 0) {
                    CategoryView(category: .NImpUrg_3rd)
                    Spacer()
                    CategoryView(category: .NImpNUrg_4th)
                }
            }.padding()
            
            TaskToday()
        }.background(Color.tBackground)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, context)
    }
}
