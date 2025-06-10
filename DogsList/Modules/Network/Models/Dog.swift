//
//  Dog.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

struct Dog: Codable {
    var dogName     : String? = nil
    var description : String? = nil
    var age         : Int?    = nil
    var image       : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case dogName     = "dogName"
        case description = "description"
        case age         = "age"
        case image       = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dogName = try values.decodeIfPresent(String.self, forKey: .dogName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
    init() { }
}
