//
//  APIManager.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

import SwiftUI
import Combine

enum NetworkError:LocalizedError, Error {
    case unknown
    case unAuthoried
    case unknowError(statusCode:Int)
    case offline
}

class APIManager {
    
    static let shared = APIManager()
    private var desposeBag:Set<AnyCancellable> = []
    
    private init() {}
    
    func callAPI<T:Decodable>(apiUrl:String,methodType:HTTPMeathod,modelData:Data? = nil, token:String?,completion:@escaping(Result<T,Error>) -> ()) {
        guard let url = URL(string:apiUrl) else { return }
        var request = URLRequest(url: url)
        request.httpBody = modelData
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token ?? "", forHTTPHeaderField: "Token")
        request.addValue("6149ac924e29ce2338d6f836", forHTTPHeaderField: "app-id")
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap{ data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                print("Status code: \(httpResponse.statusCode)")
                if 200..<300 ~= httpResponse.statusCode {
                    return data
                } else {
                    if httpResponse.statusCode == 401 {
                        throw NetworkError.unAuthoried
                    }else{
                        throw NetworkError.unknown
                    }
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &desposeBag)
    }
}
