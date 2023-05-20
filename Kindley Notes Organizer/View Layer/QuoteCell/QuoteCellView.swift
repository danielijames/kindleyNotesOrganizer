//
//  QuoteCellView.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/19/23.
//

import SwiftUI

struct QuoteCellView: View {
	
	let bookTitle: String
	let date: String
	let page: String
	let quote: String
	
    var body: some View {
		
		VStack {
			
			VStack {

				Text(bookTitle)
					.lineLimit(2)
					.padding(.horizontal)
					.frame(height: 44)
					.font(.title)
					.fontWeight(.semibold)
					.multilineTextAlignment(.leading)
					
				Text(date)
					.lineLimit(1)
					.frame(width: 540, height: 22)
					.font(.subheadline)
					.fontWeight(.medium)
					.multilineTextAlignment(.trailing)
				Divider()
			}

			Text(quote)
				.multilineTextAlignment(.center)
				.lineLimit(4)
				.padding(.all)
			Spacer()
			Divider()
			HStack {
				
				Spacer()
				Text("On page: " + page)
					.font(.subheadline)
					.fontWeight(.light)
					.multilineTextAlignment(.center)
					.padding([.top, .bottom, .trailing,. leading])
					.frame(height: 20)
					
			}

			Spacer()
		}
		.frame(
			width: 540,
			height: 280)
		.background(Color.white)
		.foregroundColor(.black)
		.border(.black, width: 3)
		.cornerRadius(14)
    }
}

struct QuoteCellView_Previews: PreviewProvider {
    static var previews: some View {
		
		QuoteCellView(
			bookTitle: "Forrest Gump",
			date: "January, 18th, 2023",
			page: "33",
			quote: "what kind of gumbo do you have bubba?")
    }
}
