//
//  NetworkManager.swift
//  TheNews
//
//  Created by vtsyganov on 25.02.2022.
//

import Foundation

enum ApiError: Error {
    case noData
    case badUrl
    case noAPIKey
    case wrongApiKey
}

protocol ApiClient {
    /* completion определяет ассинхронность функции */
    func getNews(completion: @escaping (Result<[News], Error>) -> Void)
}

class NetworkManager: ApiClient {
    static let everythingEndpoint = "https://newsdata.io/api/1/news"
    
    private let apiKeyName = "NewsAPIKey"
    private let fileManager = FileManager.shared
    
    func getNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let session = URLSession.shared
        
        guard let apiKey = fileManager.getAPIKey(apiKeyName) else {
            completion(.failure(ApiError.noAPIKey))
            return
        }
        
        let urlString = "\(NetworkManager.everythingEndpoint)?apiKey=\(apiKey)&page=1&language=en&category=top"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.badUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData)) // завершаем запрос с ошибкой
                return
            }
            print(url)
            do {
                let decoder = JSONDecoder() // определяем тип декодера данных
                let response = try decoder.decode(NewsResponse.self, from: data) // пытаемся декодировать полученные данные
                completion(.success(response.results)) // завершаем запрос с успехом
            } catch(let error) {
                print(error)
                completion(.failure(error))  // завершаем запрос с ошибкой
            }
            
        })
        
        dataTask.resume()
    }
    
}
