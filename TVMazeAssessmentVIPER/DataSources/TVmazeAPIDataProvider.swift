//
//  TVmazeAPIDataProvider.swift
//  TVMazeAssessmentVIPER
//
//  Created by Otávio Zabaleta on 16/04/2024.
//

import Foundation
import JSONHTTPClient

enum TVmazeAPIDataProviderAPIClientError: Error {
    case http(Error)
    case unknown
}

protocol TVmazeAPIDataProviderType {
    func fetchShows(page: Int) async throws -> [Show]
    func fetchEpisodes(showId: Int) async throws -> [Episode]
    func searchShows(query: String) async throws -> [Show]
}

class TVmazeAPIDataProvider: TVmazeAPIDataProviderType {
    static var shared = TVmazeAPIDataProvider()
    private let apiKey = "3Xjssgcr6q2W4MKfGhQ5Ut8tqwegAtjj"
    private var baseURL: URL {
        guard let baseURL = URL(string: "https://api.tvmaze.com") else {
            fatalError("baseURL mustn't fail to instantiate.")
        }
        return baseURL
    }
    private let httpClient: JSONHTTPClientType
    
    init(httpClient: JSONHTTPClientType = JSONHTTPClient.shared) {
        self.httpClient = httpClient
    }
    
    func fetchShows(page: Int) async throws -> [Show] {
        var fetchShowsURL = baseURL
        fetchShowsURL.append(path: "shows")
        fetchShowsURL.append(queryItems: [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ])
        
        do {
            return try await httpClient.get(fetchShowsURL, httpHeaders: nil)
        } catch {
            throw TVmazeAPIDataProviderAPIClientError.http(error)
        }
    }
    
    func fetchEpisodes(showId: Int) async throws -> [Episode] {
        var fetchEpisodesURL = baseURL
        fetchEpisodesURL.append(path: "shows/\(showId)/episodes")
        fetchEpisodesURL.append(queryItems: [URLQueryItem(name: "apiKey", value: apiKey)])
        
        do {
            return try await httpClient.get(fetchEpisodesURL, httpHeaders: nil)
        } catch {
            throw TVmazeAPIDataProviderAPIClientError.http(error)
        }
    }
    
    func searchShows(query: String) async throws -> [Show] {
        var searchShowsURL = baseURL
        searchShowsURL.append(path: "search/shows")
        searchShowsURL.append(queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "apiKey", value: apiKey)
        ])
        
        do {
            let containers: [ShowContainer] = try await httpClient.get(searchShowsURL, httpHeaders: nil)
            return containers.map { $0.show }
        } catch {
            throw TVmazeAPIDataProviderAPIClientError.http(error)
        }
    }
}
