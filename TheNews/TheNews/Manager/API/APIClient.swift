////
////  APIClient.swift
////  TheNews
////
////  Created by vtsyganov on 23.02.2022.
////
//
//import UIKit
//
//public enum APIResult<T: Codable> {
//    case failure(error: APIError)
//    case success(result: T)
//}
//
//
//public enum APIError: Error {
//    /// For client side errors, such as failing to build a request to the server.
//    case client
//
//    /// For decoding errors, such as failing to decode a response from the server.
//    case decoding(reason: [String: Any]?)
//
//    /// For network errors, such as 404 not found etc.
//    //case network(httpStatusCode: HTTPStatusCode)
//
//    /// For when the client receives an unexpected response from the server.
//    case unrecognizedFormat
//
//    /// For when the network is unreachable.
//    case unreachable
//}
//
//protocol APIClient {
//
//    var decoder: JSONDecoder { get }
//
//    var session: URLSession { get }
//
//    func cancelAllTasks()
//
//    func sendRequest<T: APIResource>(for resource: T, with parameters: APIRequest, completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask?
//}
//
//extension APIClient {
//    func cancelAllTasks() {
//        session.getAllTasks { tasks in
//            tasks.forEach { $0.cancel() }
//        }
//    }
//
//    func sendRequest<T: APIResource>(for resource: T, with parameters: APIRequest, completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask? {
//
//
//
//    }
//}
