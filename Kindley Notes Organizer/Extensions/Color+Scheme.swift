//
//  Color+Scheme.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/17/23.
//

import Foundation
import SwiftUI

extension Color {

	enum Scheme {

		static let creamyWhite: Color = Color(hex: 0xF8F6F1)
		static let lightBeige: Color = Color(hex: 0xE4D4C8)
		static let lightPeach: Color = Color(hex: 0xFCD5CE)
		static let paleYellow: Color = Color(hex: 0xFAF3DD)
		static let lightGray: Color = Color(hex: 0xC4B8A4)
	}
}

extension Color {
	
	init(hex: UInt32, alpha: Double = 1.0) {
		let red = Double((hex & 0xFF0000) >> 16) / 255.0
		let green = Double((hex & 0x00FF00) >> 8) / 255.0
		let blue = Double(hex & 0x0000FF) / 255.0
		self.init(red: red, green: green, blue: blue, opacity: alpha)
	}
}
