//
//  BooksProvider.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/18/23.
//

import Foundation
import Combine

internal final class BooksProvider {
	
	init(dataMap: DataMapProtocol,
		 kindleNotesService: KindleNotesServiceProtocol) {
		
		self.kindleNotesService = kindleNotesService
		self.dataMap = dataMap
		
		setup()
	}
	
	//MARK: Properties
	
	//Collections
	@Published
	private final var quotes: Set<Quote> = []
	@Published
	private final var books: Set<Book> = []
	
	private final var cancellable: Set<AnyCancellable> = []
	
	private final let kindleNotesService: KindleNotesServiceProtocol
	private final var dataMap: DataMapProtocol
}

//MARK: Private Helpers
extension BooksProvider {
	
	private final func setup() {
		
		setupBindings()
		kindleNotesService.fetchNewKindleFile()
	}
	
	private final func setupBindings() {
		
		self.kindleNotesService
			.kindleURLBinding
			.sink(receiveValue: {
				
				[weak self]
				
				url in
				
				guard let url = url else { return }
				
				self?.mapData(from: url)
			})
			.store(in: &self.cancellable)

		self.dataMap
			.quotesBinding
			.sink(receiveValue: {
				
				[weak self]
				
				quotes in
				
				self?.quotes = quotes
			})
			.store(in: &self.cancellable)
		
		self.dataMap
			.booksBinding
			.sink(receiveValue: {
				
				[weak self]
				
				books in
				
				self?.books = books
			})
			.store(in: &self.cancellable)
	}
	
	private final func mapData(from url: URL) {

		dataMap.map(url: url)
	}
}

//MARK: Interface
extension BooksProvider: BooksProviderProtocol {
	
	var quotesBinding: Published<Set<Quote>>.Publisher {
		
		$quotes
	}
	
	var booksBinding: Published<Set<Book>>.Publisher {
		
		$books
	}
}

//MARK: Protocols
protocol BooksProviderProtocol {

	var quotesBinding: Published<Set<Quote>>.Publisher { get }
	var booksBinding: Published<Set<Book>>.Publisher { get }
}
