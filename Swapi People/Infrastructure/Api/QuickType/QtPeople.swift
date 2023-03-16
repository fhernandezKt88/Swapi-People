//
//  QtPeople.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation

// MARK: - QtPeopleResult

struct QtPeopleResult: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var peoples: [QtPeople]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case peoples = "results"
    }
}

// MARK: - QtPeople

struct QtPeople: Codable {
    var name: String
    var height: String
    var mass: String
    var hairColor: String
    var skinColor: String
    var eyeColor: String
    var birthYear: String
    var gender: QtPeopleGender
    var homeworld: String
    var films: [String]
    var species: [String]
    var vehicles: [String]
    var starships: [String]
    var created: String
    var edited: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
        case homeworld = "homeworld"
        case films = "films"
        case species = "species"
        case vehicles = "vehicles"
        case starships = "starships"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}

// MARK: - QtPeopleGender

enum QtPeopleGender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
    case hermaphrodite = "hermaphrodite"
    case none = "none"
}
