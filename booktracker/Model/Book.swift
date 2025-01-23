//
//  Book.swift
//  booktracker
//
//  Created by Alex Hernández on 17/1/25.
//

import Foundation

struct Book: Identifiable, Codable {
    var id: String
    var title: String
    var authors: [String]
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var isbn13: String?
    var isbn10: String?
    var pageCount: Int?
    var categories: [String]?
    var imageLinks: [String: String]?
    var thumbnail: URL?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    
    init(from volumeInfo: VolumeInfo, id: String) {
        self.id = id
        self.title = volumeInfo.title
        self.authors = volumeInfo.authors ?? []
        self.publisher = volumeInfo.publisher ?? "-"
        self.publishedDate = volumeInfo.publishedDate
        self.description = volumeInfo.description ?? ""
        self.isbn13 = volumeInfo.industryIdentifiers?.first { $0.type == "ISBN_13" }?.identifier
        self.isbn10 = volumeInfo.industryIdentifiers?.first { $0.type == "ISBN_10" }?.identifier
        self.pageCount = volumeInfo.pageCount ?? 0
        self.categories = volumeInfo.categories ?? []
        self.imageLinks = volumeInfo.imageLinks ?? [:]
        self.thumbnail = volumeInfo.imageLinks?["thumbnail"].flatMap(URL.init)
        self.language = volumeInfo.language ?? ""
        self.previewLink = volumeInfo.previewLink ?? ""
        self.infoLink = volumeInfo.infoLink ?? ""
    }
    
    init(id: String, title: String, authors: [String], publisher: String?, publishedDate: String?, isbn13: String?, isbn10: String?, thumbnail: String?) {
        self.id = id
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.isbn13 = isbn13
        self.isbn10 = isbn10
        self.thumbnail = thumbnail.flatMap(URL.init)
    }
}

struct VolumeInfo: Codable {
    var title: String
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var industryIdentifiers: [IndustryIdentifier]?
    var pageCount: Int?
    var categories: [String]?
    var imageLinks: [String: String]?
    var language: String?
    var previewLink: String?
    var infoLink: String?
    var isbn13: String?
    var isbn10: String?
}

struct IndustryIdentifier: Codable {
    var type: String
    var identifier: String
}

struct GoogleBooksResponse: Decodable {
    var items: [GoogleBookItem]?
}

struct GoogleBookItem: Decodable {
    var id: String
    var volumeInfo: VolumeInfo
}
