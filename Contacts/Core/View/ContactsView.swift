//
//  ContactsView.swift
//  Contacts
//
//  Created by Dominic Montalto on 15/04/2025.
//

import SwiftUI

struct ContactsView: View {
    @State private var contacts: [Contact] = [
        .init(
            id: "1",
            firstName: "Michael",
            lastName: "Jordan",
            email: "jumpman23@gmail.com"
        ),
        .init(
            id: "2",
            firstName: "Kobe",
            lastName: "Bryant",
            email: "mamba@gmail.com"
        ),
        .init(
            id: "3",
            firstName: "Lebron",
            lastName: "James",
            email: "king.james@gmail.com"
        )
    ]
    
    @State private var searchText = ""
    @State private var showAddContactView = false
    
    var body: some View {
        NavigationStack {
            List(contacts) { contact in
                NavigationLink(value: contact) {
                    ContactsRowView(contact: contact)
                }
            }
            .sheet(isPresented: $showAddContactView) {
                AddContactView()
                    .presentationDetents([.height(300)])
            }
            .navigationDestination(for: Contact.self) { contact in
                EditContactView(contact: contact)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                      showAddContactView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Contacts")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ContactsView()
}
