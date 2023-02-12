//
//  Kindley_Notes_OrganizerApp.swift
//  Kindley Notes Organizer
//
//  Created by Daniel James on 2/12/23.
//

import SwiftUI

@main
struct Kindley_Notes_OrganizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
