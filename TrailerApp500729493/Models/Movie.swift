//
//  Movie.swift
//  TrailerApp500729493
//
//  Created by Ilias Azagagh on 4/12/19.
//  Copyright © 2019 Ilias Azagagh. All rights reserved.
//

import Foundation

// Decodes the json and saves it in variables
class Movie: Decodable {
    let id: Int
    let title: String
    let url: String
    let posterImage: String
    let stillImage: String
    let genre: [String]
    let description: String
}
