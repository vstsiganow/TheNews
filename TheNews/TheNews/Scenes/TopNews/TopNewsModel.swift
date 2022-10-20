//
//  TopNewsModel.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

struct TopNewsModel: Codable {
    let title: String
    let publishedDate: Date?
    let author: [String]?
    let imageURL: String?
}
