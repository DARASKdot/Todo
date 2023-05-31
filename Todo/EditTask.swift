
import SwiftUI

struct EditTask: View {
    
    @ObservedObject var todo:TodoEntity
    @State var showingSheet = false
    
    var categories: [TodoEntity.Category] = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NImpNUrg_4th]
    
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror) , \(nserror.userInfo)")
        }
    }
    
    fileprivate func delete() {
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("タスク名").foregroundColor(.black)) {
                TextField("タスクを入力", text: Binding($todo.task,"new task")).foregroundColor(.gray)
            }
            
            Section(header: Toggle(isOn: Binding(isNotNil:$todo.time,defaultValue:Date())){Text("時間を指定する").foregroundColor(.black)}) {
                
                if todo.time != nil {
                    DatePicker(selection: Binding($todo.time,Date()),label: { Text("日時").foregroundColor(.black) })
                } else {
                    Text("日時未設定")
                }
            }
            
            Picker(selection: $todo.category, label: Text("種類").foregroundColor(.black)) {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        CategoryImage(category)
                        Text(category.toString())
                    }.tag(category.rawValue)
                }
            }

            Section(header: Text("操作").foregroundColor(.black)) {
                Button(action: {
                    self.showingSheet = true
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "minus.circle.fill")
                        Text("削除")
                            
                    }.foregroundColor(.red)
                }
            }
        }.navigationBarTitle("タスクの編集")
            .navigationBarItems(trailing: Button(action: {
                self.save()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("閉じる")
                    .foregroundColor(.tBlue)
            })
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("タスクの削除"),message: Text("このタスクを削除します。よろしいですか？"),buttons: [.destructive(Text("削除")){
                    self.delete()
                    self.presentationMode.wrappedValue.dismiss()
                },
                .cancel(Text("キャンセル"))
            ])
        }
    }
}

struct EditTask_Previews: PreviewProvider {
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
    
    let newTodo = TodoEntity(context: context)
        return NavigationView {
            EditTask(todo: newTodo)
                .environment(\.managedObjectContext, context)
        }
    }
}
