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
    
    var searchResults: [Contact] {
        return viewModel.searchResults(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { contact in
                    NavigationLink(value: contact) {
                        ContactsRowView(contact: contact)
                            .swipeActions {
                                Button {
                                    withAnimation {
                                        viewModel.deleteContact(contact)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
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
        .environment(ContactsViewModel())
}
