//
//  Kindley_Notes_OrganizerApp.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/12/23.
//

import SwiftUI

@main
struct Kindley_Notes_OrganizerApp: App {
	
	init() {
		
		compositionRootFactory = .init()
	}
	
	//Properties
	let compositionRootFactory: CompositionRoot
	
	//Views
	var body: some Scene {
		
		WindowGroup {
			
			NavigationSplitView {
				
				List {
					
					Group {
						
						Button("Books") {
							
						}
						
						Button("Authors") {
							
						}
						
						Button("Tags") {
							
						}
						
						Button("Snapshots") {
							
						}
					}.buttonStyle(.borderless)
				}
				
			} content: {
				
				MenuView(booksViewModel: compositionRootFactory.bookListViewModel)
					.frame(width: 220)
					.navigationTitle("Books")
				
			} detail: {
				
				ZStack {
					
					BookListView(booksViewModel: compositionRootFactory.bookListViewModel)
						.cornerRadius(12)
					
					WelcomeView()
				}
			}
		}
	}
}
