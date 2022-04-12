//
//  News.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

struct NewsResponse: Codable {
    let results: [News]
}

struct News: Codable {
    let uuid: UUID = UUID()
    var title: String
    var url: String
    var keywords: [String]?
    var creator: [String]?
    var description: String?
    var content: String?
    var publishedAt: String
    var fullDescription: String?
    var imageURL: String?
    var sourceID: String?
    var country: [String]?
    var category: [Category]
    var language: String
    
    private enum NewsCodingKeys: String, CodingKey {
        case title = "title"
        case url = "link"
        case keywords = "keywords"
        case creator = "creator"
        case description = "description"
        case content = "content"
        case publishedAt = "pubDate"
        case fullDescription = "full_description"
        case imageURL = "image_url"
        case sourceID = "source_id"
        case country = "country"
        case category = "category"
        case language = "language"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsCodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.keywords = try container.decode([String]?.self, forKey: .keywords)
        self.creator = try container.decode([String]?.self, forKey: .creator)
        self.description = try container.decode(String?.self, forKey: .description)
        self.content = try container.decode(String?.self, forKey: .content)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.fullDescription = try? container.decode(String?.self, forKey: .fullDescription)
        self.imageURL = try container.decode(String?.self, forKey: .imageURL)
        self.sourceID = try container.decode(String?.self, forKey: .sourceID)
        self.country = try container.decode([String]?.self, forKey: .country)
        self.category = try container.decode([Category].self, forKey: .category)
        self.language = try container.decode(String.self, forKey: .language)
    }
    
}

enum Category: Codable, CaseIterable {
    case business, entertainment, environment, food, health, politics, science, sports, technology, top, world, other
    
    static var allCases: [Category] {
        [.business, .entertainment, .environment, .food, .health, .politics, .science, sports, .technology, .top, .world, .other]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let category = try? container.decode(String.self)
        switch category {
        case "business": self = .business
        case "entertainment": self = .entertainment
        case "environment": self = .environment
        case "food": self = .food
        case "health": self = .health
        case "politics": self = .politics
        case "science": self = .science
        case "sports": self = .sports
        case "technology": self = .technology
        case "top": self = .top
        case "world": self = .world
        default:
            self = .other
        }
    }
}

