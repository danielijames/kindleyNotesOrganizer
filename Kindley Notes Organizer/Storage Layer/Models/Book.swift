//
//  Book.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/22/23.
//

import Foundation

struct Book: Identifiable {
	
	let id: String
	let bookTitle: String
}

extension Book: Hashable {}
