import Foundation

struct ApiService {
    
    static func getAllPost(completion: @escaping (Result<[PostModel],Error>)-> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("No valid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request: \(request)\n\(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                //Verificar si hay datos anteriores y mostrar
                completion(.failure(CustomError.noData))
                return
            }
            do{
                let post = try JSONDecoder().decode([PostModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(post))
                }
            }catch let error {
                print("Request: \(request)\n\(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func getUserInfo(userId: Int,completion: @escaping (Result<UserModel,Error>)-> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)") else {
            print("No valid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request: \(request)\n\(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                //Verificar si hay datos anteriores y mostrar
                completion(.failure(CustomError.noData))
                return
            }
            do{
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            }catch let error {
                print("Request: \(request)\n\(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func getComments(postId: Int,completion: @escaping (Result<[CommentsModel],Error>)-> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            print("No valid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Request: \(request)\n\(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                //Verificar si hay datos anteriores y mostrar
                completion(.failure(CustomError.noData))
                return
            }
            do{
                let comments = try JSONDecoder().decode([CommentsModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(comments))
                }
            }catch let error {
                print("Request: \(request)\n\(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
