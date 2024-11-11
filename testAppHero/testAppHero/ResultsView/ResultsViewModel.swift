import Foundation

class ResultsViewModel: ObservableObject {
    @Published var todos: [TodoModel]

    init(todos: [TodoModel]) {
        self.todos = todos
    }
    
    func toggleCompletion(for todo: TodoModel) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completed.toggle()
        }
    }
}
