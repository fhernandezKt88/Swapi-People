//
//  Swapi.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import Moya

class Swapi {

    private let swapi = MoyaProvider<SwapiService>()

    /// Get all peoples
    public func peoples(page: Int) async throws -> QtPeopleResult? {
        return try await withCheckedThrowingContinuation({ continuation in
            self.swapi.request(.peoples(page: page)) { result in
                switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        //let string = String(data: data, encoding: .utf8)
                        //print(string ?? "")

                        do {
                            let result = try JSONDecoder().decode(QtPeopleResult.self, from: data)
                            continuation.resume(returning: result)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        })
    }

    /// Get people with id
    public func people(id: Int) async throws -> QtPeople? {
        return try await withCheckedThrowingContinuation({ continuation in
            self.swapi.request(.people(id: id)) { result in
                switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data

                        do {
                            let result = try JSONDecoder().decode(QtPeople.self, from: data)
                            continuation.resume(returning: result)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        })
    }

    /// Search for people with given query
    public func search(query: String) async throws -> QtPeopleResult? {
        return try await withCheckedThrowingContinuation({ continuation in
            self.swapi.request(.search(query: query)) { result in
                switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data

                        do {
                            let result = try JSONDecoder().decode(QtPeopleResult.self, from: data)
                            continuation.resume(returning: result)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        })
    }

}
