
import SwiftUI

struct TodoDetailRow: View {
    
    @ObservedObject var todo: TodoEntity
    
    var body: some View {
        HStack {
            CategoryImage(TodoEntity.Category(rawValue: todo.category))
            CheckBox(checked: .constant(true)){
                Text(self.todo.task ?? "no title")
            }
        }
    }
}

struct TodoDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        let container = PersistenceController.shared.container
        let context = container.viewContext
        
        let newTodo = TodoEntity(context: context)
        newTodo.task = "人脈作り"
        newTodo.state = TodoEntity.State.done.rawValue
        newTodo.category = 0
        
        return TodoDetailRow(todo: newTodo)
    }
}
