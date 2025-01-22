//
//  ListView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import FirebaseFirestore
import SwiftUI

@MainActor
struct ListView: View {
    var viewModel = FirestoreManager()
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Cargando...")
                        .padding()
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if viewModel.books.isEmpty {
                    VStack {
                        Image(systemName: "bookmark.slash")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                        
                        Text("No hay libros disponibles.\nVe a buscarlos a la pestaña de Buscar")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }

                List {
                    let upcomingBooks = viewModel.books.filter { book in
                        guard let publishedDate = book.publishedDate else { return true } // Si no tiene fecha, lo consideramos futuro
                        let currentDate = Date()
                        return publishedDate.toDate()?.isAfter(currentDate) ?? true
                    }.sorted { (book1, book2) in
                        book1.publishedDate?.toDate() ?? Date() < book2.publishedDate?.toDate() ?? Date()
                    }

                    if !upcomingBooks.isEmpty {
                        Section(header: Text("Próximamente")) {
                            ForEach(upcomingBooks) { book in
                                BookRow(book: book).onTapGesture {
                                    
                                }
                            }
                        }
                    }

                    // Sección de libros ya publicados
                    let publishedBooks = viewModel.books.filter { book in
                        guard let publishedDate = book.publishedDate else { return false } // Ignorar si no tiene fecha
                        let currentDate = Date()
                        return publishedDate.toDate()?.isBeforeOrEqual(currentDate) ?? false
                    }.sorted { (book1, book2) in
                        book1.publishedDate?.toDate() ?? Date() > book2.publishedDate?.toDate() ?? Date()
                    }

                    if !publishedBooks.isEmpty {
                        Section(header: Text("Ya Publicados")) {
                            ForEach(publishedBooks) { book in
                                BookRow(book: book).onTapGesture {
                                    let isbn = book.isbn13?.isEmpty ?? true ? book.isbn10 ?? "" : book.isbn13 ?? ""
                                    openAffiliateLink(for: book, isbn: isbn)
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Listado")
            }
            .onAppear(perform: viewModel.fetchBooks)
            .refreshable { viewModel.fetchBooks() }
        }
    }
    
    private func openAffiliateLink(for book: Book, isbn: String) {
        guard !isbn.isEmpty else { return }
        
        let amazonURL = "https://www.amazon.es/s?k=\(isbn)&crid=26KI9V6GG0ICQ&sprefix=%2Caps%2C111&ref=nb_sb_ss_recent_1_0_recent"
        
        if let url = URL(string: amazonURL) {
            UIApplication.shared.open(url)
        }
    }
}

struct BookRow: View {
    var book: Book

    var body: some View {
        HStack {
            if let thumbnail = book.thumbnail {
                AsyncImage(url: thumbnail) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFit().frame(width: 50, height: 75)
                    case .failure:
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 75)
                    default:
                        ProgressView()
                            .frame(width: 50, height: 75)
                    }
                }
            } else {
                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 75)
            }
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.authors.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let publisher = book.publisher {
                    Text("Editorial: \(publisher)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let releaseDate = book.publishedDate {
                    Text("Fecha de salida: \(releaseDate.formatDate())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

// MARK: - Helpers

extension String {
    func toDate() -> Date? {
        let formats = ["yyyy-MM-dd", "yyyy-MM"]
        for format in formats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            if let date = formatter.date(from: self) {
                return date
            }
        }
        return nil
    }
    
    func formatDate() -> String {
        guard let date = self.toDate() else { return "Fecha desconocida" }
        let locale = Locale(identifier: "es_ES")
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

extension Date {
    func isAfter(_ date: Date) -> Bool {
        return self > date
    }
    
    func isBeforeOrEqual(_ date: Date) -> Bool {
        return self <= date
    }
}
