//
//  SwapiService.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import Moya

enum SwapiService {
    case peoples(page: Int = 1)
    case people(id: Int)
    case search(query: String)
}

// MARK: - TargetType Protocol Implementation

extension SwapiService: TargetType {
    var baseURL: URL { URL(string: "https://swapi.dev/api")! }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var path: String {
        switch self {
            case .peoples:
                return "/people"
            case .people(let id):
                return "/people/\(id)"
            case .search:
                return "/people"
        }
    }

    var method: Moya.Method {
        switch self {
            case .peoples:
                return .get
            case .people:
                return .get
            case .search:
                return .get
        }
    }

    var task: Task {
        switch self {
            case .peoples(let page):
                return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
            case .people(_):
                return .requestPlain
            case .search(let query):
                return .requestParameters(parameters: ["search": query], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data { return "".utf8Encoded }
}

// MARK: - Helpers

extension String {

    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
