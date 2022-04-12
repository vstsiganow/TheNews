//
//  FileManager.swift
//  TheNews
//
//  Created by vtsyganov on 12.04.2022.
//

import Foundation

protocol APIKeysReceivable {
    func getAPIKey(_ name: String) -> String?
}

class FileManager: APIKeysReceivable {
    
    static let shared = FileManager()
    
    private let bundle = Bundle.main
    
    private init() {}
    
    func getAPIKey(_ name: String) -> String? {
        var config: [String: Any]?
        
        if let externalPlistPath = bundle.url(forResource: "ExternalInfo", withExtension: "plist") {
            do {
                let plistData = try Data(contentsOf: externalPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        return config?[name] as? String
    }
    
}
