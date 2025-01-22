//
//  SearchView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct SearchView: View {
    @State private var query: String = ""
    @State private var books: [Book] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var searchCompleted: Bool = false
    @State private var favoriteBooks: Set<String> = [] // Guarda los libros favoritos
    private let googleBooksService = GoogleBooksService()

    private let db = Firestore.firestore() // Instancia de Firestore

    var body: some View {
        NavigationView {
            VStack {
                TextField("Busca por título o autor", text: $query, onCommit: searchBooks)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onAppear(perform: {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    })
                
                if isLoading {
                    ProgressView("Cargando...")
                        .padding()
                }
                
                if !isLoading && searchCompleted && books.isEmpty {
                    Text("No se encontraron resultados para '\(query)'")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                List(books) { book in
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
                        
                        Spacer()
                        
                        Button(action: {
                            toggleFavorite(book: book)
                        }) {
                            Text(favoriteBooks.contains(book.id) ? "Añadido" : "Añadir")
                                .foregroundColor(.blue)
                        }
                        .padding(.leading, 10)
                    }
                }
                .listStyle(GroupedListStyle())
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Buscar Libros")
        }
    }

    private func searchBooks() {
        guard !query.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        searchCompleted = false
        
        Task {
            do {
                books = try await googleBooksService.searchBooks(query: query)
                checkFavoriteBooks()
            } catch {
                errorMessage = "Error: \(error.localizedDescription)"
            }
            isLoading = false
            searchCompleted = true
        }
    }

    // Marca o desmarca el libro como favorito en Firestore y actualiza la lista
    private func toggleFavorite(book: Book) {
        let favoriteBooksRef = db.collection("books").document(book.id)
        
        if favoriteBooks.contains(book.id) {
            favoriteBooksRef.delete() { error in
                if let error = error {
                    print("Error al eliminar el libro de favoritos: \(error.localizedDescription)")
                } else {
                    favoriteBooks.remove(book.id)
                }
            }
        } else {
            favoriteBooksRef.setData([
                "id": book.id,
                "title": book.title,
                "authors": book.authors,
                "thumbnail": book.thumbnail?.absoluteString ?? "",
                "publishedDate": book.publishedDate ?? "",
                "publisher": book.publisher ?? "",
                "isbn13": book.isbn13 ?? "",
                "isbn10": book.isbn10 ?? "",
            ]) { error in
                if let error = error {
                    print("Error al añadir el libro a favoritos: \(error.localizedDescription)")
                } else {
                    favoriteBooks.insert(book.id)
                }
            }
        }
    }

    // Verifica si el libro está en favoritos al cargar los resultados
    private func checkFavoriteBooks() {
        let booksRef = db.collection("books")
        
        booksRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error al obtener los favoritos: \(error.localizedDescription)")
                return
            }
            
            favoriteBooks = Set(snapshot?.documents.compactMap { document in
                document.documentID
            } ?? [])
        }
    }
}

#Preview {
    SearchView()
}
