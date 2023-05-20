//
//  CompositionRoot.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/28/23.
//

import Foundation

internal final class CompositionRoot {

	final lazy var bookListViewModel: BookListViewModel = {
		
		let dataMap: DataMap = .init()
		let kindleNotesService: KindleNotesService = .init(
			fileManager: .init(),
			nsOpenPanel: .init())
		let booksProvider: BooksProvider = .init(
			dataMap: dataMap,
			kindleNotesService: kindleNotesService)
		
		return .init(booksProvider: booksProvider)
	}()
	
	
}

