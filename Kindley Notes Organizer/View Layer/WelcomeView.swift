//
//  WelcomeView.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 3/4/23.
//

import SwiftUI

struct WelcomeView: View {
	
    var body: some View {
		
		ZStack {
			
			VStack {
				
				Text("Kindley")
					.font(.largeTitle)
					.foregroundColor(.black)
					.fontWeight(.heavy)
					
				Text("manage your notes")
					.font(.footnote)
					.foregroundColor(.black)
				Spacer()
				
				HStack{
					
					Button(role: .none) {
						
					} label: {
						
						Text("Import Notes")
						Image(systemName: "square.and.arrow.up.fill")
						
					}
					 .frame(width: 400, height: 320)
					 .padding()
					
					Button("See Current Notes") {
						
						
					}.frame(width: 200, height: 200)
					 .padding()
				}
				Spacer()
			}
		}.padding()
		 .shadow(color: .gray, radius: 1, x: 1, y: 1)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
