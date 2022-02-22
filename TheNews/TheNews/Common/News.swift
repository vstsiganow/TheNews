//
//  News.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

struct News: Codable {
    let uuid: UUID
    let title: String
    let descriptions: String
    let keywords: String
    let snippet: String
    let url: String
    let imageUrl: String
    let language: String
    let publishedAt: String
    let source: String
    let categories: [Category]
    let locale: String?
}

struct Category: Codable {
    let title: String
}
