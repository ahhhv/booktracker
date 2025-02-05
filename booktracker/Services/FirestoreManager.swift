//
//  FirestoreManager.swift
//  booktracker
//
//  Created by Alex Hernández on 17/1/25.
//

import Foundation
import FirebaseFirestore
import Combine
import Firebase

@Observable
class FirestoreManager {
    var books: [Book] = []
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        Firestore.firestore().collection("books").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            self.books = documents.map { queryDocumentSnapshot -> Book in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let authors = data["authors"] as? [String] ?? []
                let publisher = data["publisher"] as? String ?? ""
                let publishedDate = data["publishedDate"] as? String ?? ""
                let thumbnail = data["thumbnail"] as? String ?? ""
                _ = data["pageCount"] as? Int ?? .zero
                let isbn13 = data["isbn13"] as? String ?? ""
                let isbn10 = data["isbn10"] as? String ?? ""
                
                return Book(id: id, title: title, authors: authors, publisher: publisher, publishedDate: publishedDate, isbn13: isbn13, isbn10: isbn10, thumbnail: thumbnail)
            }
        }
    }
}

