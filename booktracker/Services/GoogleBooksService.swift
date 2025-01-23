//
//  GoogleBooksService.swift
//  booktracker
//
//  Created by Alex Hernández on 17/1/25.
//

import Foundation

class GoogleBooksService {
    func searchBooks(query: String) async throws -> [Book] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(encodedQuery)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
        
        return decodedResponse.items?.compactMap { item in
            let volumeInfo = item.volumeInfo
            return Book(from: volumeInfo, id: item.id)
        } ?? []
    }
}

