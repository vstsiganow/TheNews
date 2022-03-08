//
//  News.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [News]
}

struct News: Codable {
    let uuid: UUID = UUID()
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let imageUrl: String
    let publishedAt: String
    let content: String
    
    private enum NewsCodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case imageUrl = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
//    init(source: Source?, author: String?, title: String, desc: String?, url: String?, imageUrl: String?, publishedAt: String?, content: String?) {
//        self.source = source
//        self.author = author
//        self.title = title
//        self.description = desc
//        self.url = url
//        self.imageUrl = imageUrl
//        self.publishedAt = publishedAt
//        self.content = content
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.content = try container.decode(String.self, forKey: .content)
        self.source = try container.decode(Source.self, forKey: .source)
    }
    
}

struct Source: Codable {
    var id: String?
    var name: String
    
    init(id: String? = "", name: String) {
        self.id = id
        self.name = name
    }
    
    private enum SourceCodingKeys: String, CodingKey {
        case id, name
    }
}

