////
////  APIRequest.swift
////  TheNews
////
////  Created by vtsyganov on 24.02.2022.
////
//
//import Foundation
//
//enum searchFields: String {
//    case title, description, content, none
//
//    var allCasesDescription: String {
//        "\(searchFields.title.rawValue),\(searchFields.description.rawValue),\(searchFields.content.rawValue)"
//    }
//
//    var description: String {
//        switch self {
//        case .title, .description, .content:
//            return self.rawValue
//        case .none:
//            return allCasesDescription
//        }
//
//    }
//}
//
//enum sortOptions: String {
//    case relevancy, popularity, publishedAt
//}
//
//struct APIRequest {
//    var query: String = "now"
//    var searchIn: [searchFields] = [.none]
//    var sources: [String] = []
//    var domains: [String] = []
//    var excludedDomain: [String] = []
//    var dateFrom: Date? = Date().description.toDate(with: "yyyy-MM-dd")
//    var dateTo: Date? = Date().description.toDate(with: "yyyy-MM-dd")
//    var language: [String] = []
//    var sortedBy: sortOptions = .publishedAt
//    var paheSize: Int = 50
//    var page: Int = 1
//
//    var buildRequestsText: String {
//
//        return "q=\("sdfs\(query)")&searchIn=\(searchIn)"
//    }
//
//    private func concatenateStringArray(with array: [String]) -> String {
//
//    }
//
//    static var testRequest = APIRequest(query: "apple", dateFrom: "2022-02-22".toDate(with: "yyyy-MM-dd"), dateTo:  "2022-02-22".toDate(with: "yyyy-MM-dd"))
//}
