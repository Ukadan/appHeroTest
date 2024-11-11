import Foundation

@MainActor
class FetcherViewModel: ObservableObject {
    @Published var todos: [TodoModel] = []
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchTodos(isAll: Bool) async {
        do {
            let todos = try await isAll ? networkService.fetchTodo() : networkService.fetchTodos()
            self.todos = todos
        } catch {
            print("Ошибка при загрузке данных: \(error)")
        }
    }
}
