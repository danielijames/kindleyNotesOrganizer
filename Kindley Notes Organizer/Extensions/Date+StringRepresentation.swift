//
//  Date+StringRepresentation.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/19/23.
//

import Foundation

extension Date {
	
	private static let formatter = DateFormatter()
	
	static func hyphenatedString() -> String {
		
		Date.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return Date.formatter.string(from: .init())
	}
}
