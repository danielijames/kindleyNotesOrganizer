//
//  MenuView.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/22/23.
//

import SwiftUI

struct MenuView: View {
	
	@StateObject var booksViewModel: BookListViewModel
	
	var body: some View {
		
		ZStack {
			
			List(booksViewModel.bookTitles) { title in
				
				HStack(alignment: .top) {
					
					VStack(alignment: .leading) {
						
						Section {
							Button(title.bookTitle) {
								print(title.bookTitle)
							}.buttonStyle(.borderless)
								.font(.headline)
						}
					}
					Spacer()
					
				}
			}.listStyle(.sidebar)
		}
	}
}
