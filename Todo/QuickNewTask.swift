
import SwiftUI

struct QuickNewTask: View {
    
    let category: TodoEntity.Category
    
    @State var newTask: String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewTask() {
        TodoEntity.create(in: self.viewContext, category: self.category, task: self.newTask)
    }
    
    fileprivate func cancelTask() {
        self.newTask = ""
    }
    
    var body: some View {
        HStack {
            TextField("新しいタスクを入力", text: $newTask) {
                self.addNewTask()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                self.addNewTask()
            } ) {
                Text("追加")
            }
            
            Button(action: {
                self.cancelTask()
            } ) {
                Text("キャンセル")
                    .foregroundColor(.red)
            }
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    
    static let container = PersistenceController.shared.container
    static let context = container.viewContext

    static var previews: some View {
        QuickNewTask(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
