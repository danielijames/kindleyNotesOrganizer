//
//  DataMap.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/19/23.
//

import Foundation
import Combine

internal final class DataMap: DataMapProtocol {
	
	init() {
		
		
	}
	
	internal final var booksBinding: Published<Set<Book>>.Publisher { $books }
	
	internal final var quotesBinding: Published<Set<Quote>>.Publisher { $quotes }
		
	@Published private final var books: Set<Book> = []
	
	@Published private final var quotes: Set<Quote> = []
	
	private final var publisher: AnyPublisher<Data, URLSession.DataTaskPublisher.Failure>?
}

//MARK: Interface
extension DataMap {
	
	internal func map(url: URL) {
		
		publisher = URLSession
			.shared
			.dataTaskPublisher(for: url)
			.map(\.data)
			.multicast {
				PassthroughSubject<Data, URLError>()
			}
			.eraseToAnyPublisher()
		
		guard
			let text = try? String.init(contentsOf: url, encoding: .utf8)
		else { return }

		let (quotes, books) = mapBooksAndQuotes(text: text)

		self.quotes = quotes
		self.books = books
	}
}

extension DataMap {
	
	private final func getOrCreateBookId(ids: inout [String:UUID], title: String) -> UUID {
		
		if let id = ids[title] {
			return id
		}
		
		let newUUID: UUID = .init()
		
		ids[title] = newUUID
		
		return newUUID
	}
	
	private final func mapBooksAndQuotes(text: String) -> (quotes: Set<Quote>, books: Set<Book>)
	{
		
		var quotes: Set<Quote> = []
		var books: Set<Book> = []
		var bookIdsByTitle: [String:UUID] = [:]
		
		//Divide text into groups
		let quoteGroups = text.split(separator: Keys.mainSeparator)
		
		//For each group which is a Quote Body that contains authors and data
		for group in quoteGroups {
			
			//Each group has data on a new line
			let components = group
				.components(separatedBy: Keys.newLineSeparator)
				.filter{ $0 != "" }
			guard
				components.count > 2
			else { continue }
			
			//Title is located first and contains the author aswell
			let title = components[0]
			
			//date and time are the second element
			let locationAndTime = components[1]
			
			//The quote is final, can be nil if the user quoted a picture
			let quote = components[2]
			
			//Separate the date from the page location
			let locationAndTimeComponents = locationAndTime.split(separator: Keys.pipeSeparator)
			
			guard
				locationAndTimeComponents.count > 2
			else { continue }
			
			let page = String(locationAndTimeComponents[0].filter{$0.isNumber})
			let date = String(locationAndTimeComponents[2].dropFirst(9))
			
			let bookId: UUID = getOrCreateBookId(
				ids: &bookIdsByTitle,
				title: title)
			
			let quoteModel: Quote = .init(
				bookId: bookId,
				bookTitle: title,
				quote: quote,
				page: page,
				date: date)
			quotes.insert(quoteModel)
			
			let bookModel: Book = .init(
				id: getOrCreateBookId(
					ids: &bookIdsByTitle,
					title: title).uuidString,
				bookTitle: title)
			books.insert(bookModel)
		}
		
		return (quotes, books)
	}
}

protocol DataMapProtocol {
	
	mutating func map(url: URL)
	var booksBinding: Published<Set<Book>>.Publisher { get }
	var quotesBinding: Published<Set<Quote>>.Publisher { get }
}

fileprivate enum Keys {
	
	static let mainSeparator = "=========="
	static let pipeSeparator = " | "
	static let newLineSeparator = "\r\n"
}
