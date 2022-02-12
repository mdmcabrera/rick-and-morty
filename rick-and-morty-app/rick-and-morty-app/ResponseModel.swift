//
//  ResponseModel.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 03/02/2022.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class ResponseInfo: Object, Codable {
    dynamic var info: Info? = nil
    var results = List<Character>()
}

@objcMembers class Info: Object, Codable {
    dynamic var count: Int = 0
    dynamic var pages: Int = 0
    dynamic var next: String? = nil
    dynamic var prev: String? = nil
}

@objcMembers class Character: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var status: String = ""
    dynamic var gender: String = ""
    dynamic var origin: Origin? = nil
    dynamic var location: Location? = nil
    
    dynamic var image: String = ""
    var episode = List<String>()
    dynamic var url: String = ""
    dynamic var created: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class Origin: Object, Codable {
    dynamic var name: String = ""
    dynamic var url: String = ""
}

@objcMembers class Location: Object, Codable {
    dynamic var name: String = ""
    dynamic var url: String = ""
}
