//
//  Joke.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Jose Javier on 27/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

struct Joke: Codable {
    
    let message: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case message = "value"
        case iconUrl = "icon_url"
    }
    
}
