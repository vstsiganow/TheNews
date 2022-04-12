//
//  RegularNewsModel.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

struct RegularNewsModel: Codable {
    let title: String
    let publishedDate: Date?
    let author: [String]?
    let imageURL: String?
}
