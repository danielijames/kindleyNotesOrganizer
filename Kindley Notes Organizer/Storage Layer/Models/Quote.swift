//
//  Quote.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/18/23.
//

import Foundation

// SAMPLE
/* The YouTube Formula: How Anyone Can Unlock the Algorithm to Drive Views, Build an Audience, and Grow Revenue (Derral Eves)
 - Your Highlight on page 129 | Location 1970-1970 | Added on Wednesday, December 14, 2022 9:14:47 PM
 
 Utilize tracking systems, ideally with omnichannel attribution.
 */

struct Quote: Identifiable {
	
	let id = UUID().uuidString
	let bookId: UUID

	let bookTitle: String
	let quote: String
	let page: String
	let date: String
}

extension Quote: Hashable {
	
	static func == (lhs: Quote, rhs: Quote) -> Bool {
		lhs.id == rhs.id
	}
}
