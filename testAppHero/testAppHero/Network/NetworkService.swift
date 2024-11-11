import Foundation

protocol NetworkServiceProtocol {
    func fetchTodos() async throws -> [TodoModel]
    func fetchTodo() async throws -> [TodoModel]
}

class NetworkService: NetworkServiceProtocol {
    func fetchTodos() async throws -> [TodoModel] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let todos = try JSONDecoder().decode([TodoModel].self, from: data)
        return todos
    }
    
    func fetchTodo() async throws -> [TodoModel] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos?userId=5") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let todos = try JSONDecoder().decode([TodoModel].self, from: data)
        return todos
    }
}
