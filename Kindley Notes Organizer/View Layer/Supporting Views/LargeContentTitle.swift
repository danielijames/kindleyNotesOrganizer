//
//  LargeContentTitle.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/17/23.
//

import SwiftUI

struct LargeContentTitle: View {
	
	let title: String
	
    var body: some View {
		
		ZStack {
			
			Color.Scheme.lightGray
			
			HStack {
				Text(title)
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(Color.black)
					.multilineTextAlignment(.center)
					.lineLimit(1)
					.padding()
			}.frame(height: 44)
		}
		.ignoresSafeArea(.all)
		.frame(height: 44)
    }
}
