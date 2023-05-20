//
//  BookListView.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/17/23.
//

import SwiftUI

struct BookListView: View {
	
	@StateObject var booksViewModel: BookListViewModel

	var body: some View {

			ZStack {
				
				Color.white.edgesIgnoringSafeArea(.all)
				
				ScrollView {
					
					LazyVGrid(columns: [GridItem(.adaptive(minimum: 540))]) {
						
						ForEach(booksViewModel.searchQuotes, id: \.id) { quote in
							
							QuoteCellView(
								bookTitle: quote.bookTitle,
								date: quote.date,
								page: quote.page,
								quote: quote.quote)
							
						}
					}
					.searchable(text: $booksViewModel.searchText)
					.padding(.all, 24.0)
				}
			}
	}
}
