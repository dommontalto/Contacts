//
//  ContactsView.swift
//  Contacts
//
//  Created by Dominic Montalto on 15/04/2025.
//

import SwiftUI

struct ContactsView: View {
    @State private var viewModel = ContactsViewModel()
    @State private var searchText = ""
    @State private var showAddContactView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.contacts) { contact in
                    NavigationLink(value: contact) {
                        ContactsRowView(contact: contact)
                    }
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
