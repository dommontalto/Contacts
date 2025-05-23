//
//  ContactsApp.swift
//  Contacts
//
//  Created by Dominic Montalto on 15/04/2025.
//

import SwiftUI

@main
struct ContactsApp: App {
    @State private var viewModel = ContactsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContactsView()
                .environment(viewModel)
        }
    }
}
